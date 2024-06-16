#include "muduo/file/uring_file.h"
#include "muduo/net/EventLoop.h"
#include <gtest/gtest.h>
#include <iostream>
#include <memory>
#include <sstream>
#include <string>
#include <bits/types/struct_iovec.h>
#include <cstddef>
#include <cstdlib>
#include <fstream>


TEST(uring_test, test_read) {

  std::ofstream file("test", std::ios::trunc);
  if (file) {
    file << "123123";
    file.flush();
    file.close();
  } else {
    abort();
  }

  EventLoop loop;
  std::string buf;

  // 只能使用queueInLoop将其放在eventloop中执行，否则会直接执行
  loop.queueInLoop([&]() {
    auto uring_mgr = loop.getFileManager();
    auto file = uring_mgr->registeFile("test");
    
    file->readFile(
        buf,
        [&](int res, std::string buf) {
          ASSERT_EQ(res, 6);
          loop.runInLoop([&loop]() { loop.quit(); });
        });
  });

  // 告诉loop需要执行上面的functor，否则一直陷入epoll
  loop.wakeup();
  loop.loop();

  ASSERT_EQ(buf, std::string("123123"));
}
