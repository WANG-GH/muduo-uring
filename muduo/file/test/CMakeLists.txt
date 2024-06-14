add_executable(uring_file_test uring_file_test.cpp)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(GoogleTest)

enable_testing()

target_link_libraries(uring_file_test muduo_net muduo_base uring_file GTest::gtest_main)