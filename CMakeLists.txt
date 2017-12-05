cmake_minimum_required(VERSION 3.0)

option(HUNTER_ENABLED "Enable Hunter package manager" NO)
include("cmake/Hunter/HunterGate.cmake")
HunterGate(
        URL "https://github.com/ruslo/hunter/archive/v0.19.167.tar.gz"
        SHA1 "244a13718ea2e6c0c8998d15559c7e459f615708"
)

project(SDL_ttf VERSION 2.0.14)

hunter_add_package(freetype)
find_package(freetype CONFIG REQUIRED)

hunter_add_package(SDL2)
find_package(SDL2 CONFIG REQUIRED)

set(SRC_C_FILES
        SDL_ttf.c
        )

set(SRC_H_FILES
        SDL_ttf.h
        )

set(SRC_FILES ${SRC_C_FILES} ${SRC_H_FILES})

add_library(${PROJECT_NAME} ${SRC_FILES})

target_link_libraries(${PROJECT_NAME} PUBLIC freetype::freetype SDL2::SDL2 SDL2::SDL2main)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
        "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
        COMPATIBILITY SameMajorVersion
)

set(TARGETS_EXPORT_NAME "${PROJECT_NAME}Targets")
configure_package_config_file(
        "${CMAKE_CURRENT_LIST_DIR}/cmake/SDL_ttf_Config.cmake.in"
        "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
        INSTALL_DESTINATION "lib/cmake/${PROJECT_NAME}"
)

install(TARGETS ${PROJECT_NAME} EXPORT 
        "${PROJECT_NAME}Targets"
        LIBRARY DESTINATION "lib"
        ARCHIVE DESTINATION "lib"
        INCLUDES DESTINATION "include")

install(
        FILES
        "SDL_ttf.h"
        DESTINATION
        "include/SDL_ttf")

install(
        FILES
        "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
        "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
        DESTINATION
        "lib/cmake/${PROJECT_NAME}")

install(EXPORT "${PROJECT_NAME}Targets"
        FILE "${PROJECT_NAME}Targets.cmake"
        NAMESPACE "${PROJECT_NAME}::"
        DESTINATION "lib/cmake/${PROJECT_NAME}")
