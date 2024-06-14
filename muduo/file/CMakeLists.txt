add_library(uring_file uring_file.cpp)
target_compile_options(uring_file PUBLIC -std=c++23)
target_link_libraries(uring_file uring)
add_subdirectory(test)