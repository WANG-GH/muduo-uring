 # pragma once

#include "muduo/net/Channel.h"
#include <bits/types/struct_iovec.h>
#include <cstddef>
#include <fcntl.h>
#include <functional>
#include <memory>
#include <string>
#include <liburing.h>
#include <unordered_map>

using muduo::net::EventLoop;

namespace muduo {
namespace file {

using muduo::net::EventLoop;
using muduo::net::Channel;
using std::string;
using std::unordered_map;
using std::weak_ptr;
using std::shared_ptr;

class FileManager;
struct IOContext;

enum FileOP {READ, WRITE};

// 回调是个引用，该引用指向了用户提供的buf
using FileCallBack = std::function<void(int, string&)>;

class File: public std::enable_shared_from_this<File>{
  public:
    File(int fd, int size, shared_ptr<FileManager> mgr): fd_(fd), size_(size), mgr_(mgr){}
    ~File();

    int getFd(){return fd_;}
    size_t getSize(){return size_;}
    int* getFdAddr(){return &fd_;}
    void readFile(string& buf, FileCallBack&& cb);
    void writeFile(string& buf, FileCallBack&& cb);
  private:
    int fd_;
    size_t size_;
    weak_ptr<FileManager> mgr_;
};

// 传输上下文，其中fileBuf的生命周期由用户决定，整体ctx的生命周期由FileManager决定
struct IOContext{
  string& fileBuf; // 用户自己的缓冲区
  shared_ptr<File> file;
  FileCallBack cb;
  FileOP op;
};

class FileManager: public std::enable_shared_from_this<FileManager>{
  public:
    FileManager(shared_ptr<EventLoop> loop);
    ~FileManager();
    void submitReadFile(IOContext&& ctx);
    void submitWriteFile(IOContext&& ctx);
    void handleEventRead();
    std::shared_ptr<File> registeFile(std::string path);
    
  private:
    int eventfd_;
    Channel channel_;
    struct io_uring uring_;
    weak_ptr<EventLoop> loop_;
    unordered_map<int, IOContext> ctxMap_;
    static const unsigned URING_ENTRYS = 8;
};

} // file
} // muduo
