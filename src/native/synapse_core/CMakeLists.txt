cmake_minimum_required(VERSION 3.21)

project(synapse_core LANGUAGES C)

add_library(synapse_core SHARED
    src/synapse_shell_contract.c
)

target_compile_definitions(synapse_core PRIVATE SYNAPSE_CORE_EXPORTS)
target_include_directories(synapse_core PUBLIC include)
target_compile_features(synapse_core PRIVATE c_std_11)

set_target_properties(synapse_core PROPERTIES
    OUTPUT_NAME "synapse_core"
)
