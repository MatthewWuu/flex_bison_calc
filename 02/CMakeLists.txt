cmake_minimum_required(VERSION 3.14)
project(test)

set(CMAKE_CXX_STANDARD 11)

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)

#FLEX_TARGET(scanner test.l ${CMAKE_CURRENT_BINARY_DIR}/test.cpp)

#add_executable(test ${FLEX_scanner_OUTPUTS})

BISON_TARGET(parser ${CMAKE_SOURCE_DIR}/calc.y ${CMAKE_CURRENT_BINARY_DIR}/parser.cpp)
FLEX_TARGET(lexer ${CMAKE_SOURCE_DIR}/calc.l ${CMAKE_CURRENT_BINARY_DIR}/lexer.cpp)
ADD_FLEX_BISON_DEPENDENCY(lexer parser)

include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories(${CMAKE_SOURCE_DIR})

add_executable(calc main.cpp ${FLEX_lexer_OUTPUTS} ${BISON_parser_OUTPUTS} ${PROJECT_SOURCE_DIR}/funcs.hpp)
