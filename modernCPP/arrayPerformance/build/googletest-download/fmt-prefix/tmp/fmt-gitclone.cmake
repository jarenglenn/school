
if(NOT "/home/jaren/development/school/cpp/arrayPerformance/build/googletest-download/fmt-prefix/src/fmt-stamp/fmt-gitinfo.txt" IS_NEWER_THAN "/home/jaren/development/school/cpp/arrayPerformance/build/googletest-download/fmt-prefix/src/fmt-stamp/fmt-gitclone-lastrun.txt")
  message(STATUS "Avoiding repeated git clone, stamp file is up to date: '/home/jaren/development/school/cpp/arrayPerformance/build/googletest-download/fmt-prefix/src/fmt-stamp/fmt-gitclone-lastrun.txt'")
  return()
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} -E rm -rf "/home/jaren/development/school/cpp/arrayPerformance/build/fmt-src"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to remove directory: '/home/jaren/development/school/cpp/arrayPerformance/build/fmt-src'")
endif()

# try the clone 3 times in case there is an odd git clone issue
set(error_code 1)
set(number_of_tries 0)
while(error_code AND number_of_tries LESS 3)
  execute_process(
    COMMAND "/usr/bin/git"  clone --no-checkout --config "advice.detachedHead=false" "https://github.com/fmtlib/fmt.git" "fmt-src"
    WORKING_DIRECTORY "/home/jaren/development/school/cpp/arrayPerformance/build"
    RESULT_VARIABLE error_code
    )
  math(EXPR number_of_tries "${number_of_tries} + 1")
endwhile()
if(number_of_tries GREATER 1)
  message(STATUS "Had to git clone more than once:
          ${number_of_tries} times.")
endif()
if(error_code)
  message(FATAL_ERROR "Failed to clone repository: 'https://github.com/fmtlib/fmt.git'")
endif()

execute_process(
  COMMAND "/usr/bin/git"  checkout 8.0.1 --
  WORKING_DIRECTORY "/home/jaren/development/school/cpp/arrayPerformance/build/fmt-src"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to checkout tag: '8.0.1'")
endif()

set(init_submodules TRUE)
if(init_submodules)
  execute_process(
    COMMAND "/usr/bin/git"  submodule update --recursive --init 
    WORKING_DIRECTORY "/home/jaren/development/school/cpp/arrayPerformance/build/fmt-src"
    RESULT_VARIABLE error_code
    )
endif()
if(error_code)
  message(FATAL_ERROR "Failed to update submodules in: '/home/jaren/development/school/cpp/arrayPerformance/build/fmt-src'")
endif()

# Complete success, update the script-last-run stamp file:
#
execute_process(
  COMMAND ${CMAKE_COMMAND} -E copy
    "/home/jaren/development/school/cpp/arrayPerformance/build/googletest-download/fmt-prefix/src/fmt-stamp/fmt-gitinfo.txt"
    "/home/jaren/development/school/cpp/arrayPerformance/build/googletest-download/fmt-prefix/src/fmt-stamp/fmt-gitclone-lastrun.txt"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to copy script-last-run stamp file: '/home/jaren/development/school/cpp/arrayPerformance/build/googletest-download/fmt-prefix/src/fmt-stamp/fmt-gitclone-lastrun.txt'")
endif()

