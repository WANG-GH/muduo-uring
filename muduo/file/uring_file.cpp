#include "uring_file.h"
#include "muduo/base/Logging.h"
#include "muduo/net/Channel.h"
#include <bits/types/struct_iovec.h>
#include <liburing.h>
#include <memory>
#include <unistd.h>
#include <utility>
#include <sys/eventfd.h>


using namespace muduo::file;

File::~File(){
  ::close(fd_);
}

void File::readFile(string& buf, FileCallBack&& cb){
  buf.reserve(size_);

  IOContext ctx = {
    .fileBuf = buf,
    .file = shared_from_this(),
    .cb = std::move(cb),
    .op = READ,
  };

  //其实这里该做错误处理的，但是懒得写了
  auto mgr = mgr_.lock();
  mgr->submitReadFile(std::move(ctx));
}

void File::writeFile(string& buf, FileCallBack&& cb){
  IOContext ctx = {
    .fileBuf = buf,
    .file = shared_from_this(),
    .cb = std::move(cb),
    .op = WRITE
  };

  //其实这里该做错误处理的，但是懒得写了
  auto mgr = mgr_.lock();
  mgr->submitWriteFile(std::move(ctx));
}

int createEventfd() {
  int evtfd = ::eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
  if (evtfd < 0) {
    abort();
  }
  return evtfd;
}

// 
FileManager::FileManager(shared_ptr<EventLoop> loop)
  : eventfd_(createEventfd()), channel_(loop.get(), eventfd_), loop_(loop)
{
  // 防止地址发生变化
  ctxMap_.reserve(URING_ENTRYS);
  if (io_uring_queue_init(URING_ENTRYS, &uring_, 0) < 0) {
		LOG_SYSERR << "Failed to init iouring";
		abort();
	}
	if (io_uring_register_eventfd(&uring_, eventfd_) < 0) {
		LOG_SYSERR << "Failed to register eventfd on iouring";
		abort();
	}

	channel_.setReadCallback(std::bind(&FileManager::handleEventRead, this));
	channel_.enableReading();
}

FileManager::~FileManager(){
  channel_.disableAll();
	channel_.remove();

	io_uring_unregister_eventfd(&uring_);
	io_uring_queue_exit(&uring_);

	::close(eventfd_);
}


void FileManager::submitReadFile(IOContext&& ctx){
  auto submit = [this, ctx{std::move(ctx)}](){
    io_uring_sqe *sqe = io_uring_get_sqe(&uring_);
    int fd = ctx.file->getFd();

    io_uring_prep_read(sqe, fd, ctx.fileBuf.data(), static_cast<unsigned int>(ctx.file->getSize()), 0);
    io_uring_sqe_set_data(sqe, ctx.file->getFdAddr());

    io_uring_submit(&uring_);
    // assert(ret == 1);

    // 本身ctx就是右值
    ctxMap_.emplace(ctx);
  };
  
  auto loop = loop_.lock();
  loop->runInLoop(std::move(submit));
}

void FileManager::submitWriteFile(IOContext&& ctx){
  auto submit = [this, ctx{std::move(ctx)}](){
    io_uring_sqe *sqe = io_uring_get_sqe(&uring_);
    int fd = ctx.file->getFd();

    io_uring_prep_write(sqe, fd, ctx.fileBuf.data(), static_cast<unsigned int>(ctx.file->getSize()), 0);
    io_uring_sqe_set_data(sqe, ctx.file->getFdAddr());

    io_uring_submit(&uring_);

    // 本身ctx就是右值
    ctxMap_.emplace(ctx);
  };
  
  auto loop = loop_.lock();
  loop->runInLoop(std::move(submit));
}

void FileManager::handleEventRead(){
  auto loop = loop_.lock();
  loop->assertInLoopThread();
	uint64_t buf = 0;
	if (::read(eventfd_, &buf, 8) != 8) {
		LOG_SYSERR << "Failed to read from eventfd in iouring";
		abort();
	}

  while(true){
    io_uring_cqe *cqe = nullptr;
    int ret = io_uring_peek_cqe(&uring_, &cqe);

    if (ret == -EAGAIN) {
			LOG_DEBUG << "Consumed all pending CQEs";
			break;
		} else if (ret != 0) {
			LOG_SYSERR << "Failed to peek CQE";
		}

    void* user_data = io_uring_cqe_get_data(cqe);
    int fd = *static_cast<int*>(user_data);
    LOG_INFO << "Get CQE " << fd;

    IOContext ctx = ctxMap_.at(fd);
    // TODO：check safety
    ctx.cb(cqe->res, ctx.fileBuf);
    io_uring_cqe_seen(&uring_, cqe);
  }
}
