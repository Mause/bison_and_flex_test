cmake_minimum_required(VERSION 2.8)

#SET(CMAKE_VERBOSE_MAKEFILE ON)
#set(VERBOSE, ON)
#SET(DEBUG, ON)

find_package(BISON)
find_package(FLEX)

BISON_TARGET(
    Parser ${CMAKE_CURRENT_SOURCE_DIR}/src/parser.y ${CMAKE_CURRENT_BINARY_DIR}/parser.cpp
    COMPILE_FLAGS "-v")# --language=c++")
FLEX_TARGET(
    Scanner ${CMAKE_CURRENT_SOURCE_DIR}/src/tokens.l ${CMAKE_CURRENT_BINARY_DIR}/tokens.cpp
    COMPILE_FLAGS "-v --header-file=${CMAKE_CURRENT_BINARY_DIR}/tokens.hpp") # --c++ ")
ADD_FLEX_BISON_DEPENDENCY(Scanner Parser)

message("-- Flex output: " ${FLEX_Scanner_OUTPUTS})
message("-- Bison output: " ${BISON_Parser_OUTPUTS})

include_directories(${CMAKE_CURRENT_BINARY_DIR})
add_executable(ex
    ${FLEX_Scanner_OUTPUTS}
    ${BISON_Parser_OUTPUTS}
)

#lex lex.y
#yacc -d Grammar.y
#bison --debug Grammar.y
#cc lex.yy.c Grammar.tab.c -o ex
#:rm lex.yy.c Grammar.tab.c
