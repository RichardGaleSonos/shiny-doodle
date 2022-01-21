cmake_minimum_required(VERSION 3.14)
project(moderncpp CXX)

# to build:
#   mkdir x64
#   cd x64
#   cmake -DCMAKE_CXX_COMPILER=/usr/bin/clang ..

#   mkdir a113
#   cd a113
#   cmake -DCMAKE_TOOLCHAIN_FILE=~/git/shiny-doodle/cmake/a113.cmake ..

set(SRC_FILES
    constexpr_const.cpp
    constexpr_constexpr.cpp
    constexpr_define.cpp
    constfn_compiletime.cpp
    constfn_runtime.cpp
    containers_class_c_array.cpp
    containers_class_c_iostream.cpp
    containers_class_std_array.cpp
    containers_pod_c_array.cpp
    containers_pod_std_array.cpp
    copy_elision.cpp
    lambdas_callback.cpp
    lambdas_lambda.cpp
    override_bug.cpp
    # override_error.cpp
    # unique_ptr_bug.cpp
    # unique_ptr.cpp
)

foreach(SRC ${SRC_FILES})
    get_filename_component(EXE "${SRC}" NAME_WE)
    add_executable(${EXE} ${SRC})

    add_custom_command(
        TARGET ${EXE}
        POST_BUILD
        COMMAND ${CMAKE_OBJDUMP} --disassemble ${EXE} > ${EXE}.txt
    )

    # add_custom_command(
    #     TARGET ${EXE}
    #     POST_BUILD
    #     COMMAND clang++ -ftime-trace -c ${CMAKE_SOURCE_DIR}/${SRC}
    # )
endforeach()
