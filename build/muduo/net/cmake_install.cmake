# Install script for directory: /home/wyy/prog/homework/muduo_uring/muduo/net

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/wyy/prog/homework/muduo_uring/build/lib/libmuduo_net.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/muduo/net" TYPE FILE FILES
    "/home/wyy/prog/homework/muduo_uring/muduo/net/Buffer.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/net/Callbacks.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/net/Channel.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/net/Endian.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/net/EventLoop.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/net/EventLoopThread.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/net/EventLoopThreadPool.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/net/InetAddress.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/net/TcpClient.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/net/TcpConnection.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/net/TcpServer.h"
    "/home/wyy/prog/homework/muduo_uring/muduo/net/TimerId.h"
    )
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/wyy/prog/homework/muduo_uring/build/muduo/net/http/cmake_install.cmake")
  include("/home/wyy/prog/homework/muduo_uring/build/muduo/net/inspect/cmake_install.cmake")
  include("/home/wyy/prog/homework/muduo_uring/build/muduo/net/tests/cmake_install.cmake")
  include("/home/wyy/prog/homework/muduo_uring/build/muduo/net/protobuf/cmake_install.cmake")
  include("/home/wyy/prog/homework/muduo_uring/build/muduo/net/protorpc/cmake_install.cmake")

endif()

