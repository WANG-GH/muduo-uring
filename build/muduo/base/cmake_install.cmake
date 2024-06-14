# Install script for directory: /home/wyy/prog/homework/muduo_uring/muduo/base

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/wyy/prog/homework/muduo_uring/build/lib/libmuduo_base.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/muduo/base" TYPE FILE FILES
    "/home/wyy/prog/homework/muduo_uring/muduo/base/AsyncLogging.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/Atomic.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/BlockingQueue.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/BoundedBlockingQueue.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/Condition.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/CountDownLatch.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/CurrentThread.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/Date.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/Exception.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/FileUtil.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/GzipFile.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/LogFile.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/LogStream.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/Logging.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/Mutex.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/ProcessInfo.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/Singleton.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/StringPiece.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/Thread.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/ThreadLocal.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/ThreadLocalSingleton.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/ThreadPool.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/TimeZone.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/Timestamp.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/Types.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/WeakCallback.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/copyable.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/base/noncopyable.h"
    )
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/wyy/prog/homework/muduo_uring/build/muduo/base/tests/cmake_install.cmake")

endif()

