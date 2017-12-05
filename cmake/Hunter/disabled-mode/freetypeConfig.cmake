if(TARGET freetype::freetype)
    return()
endif()

find_package(Freetype MODULE REQUIRED)

add_library(freetype::freetype UNKNOWN IMPORTED)
set_target_properties(
        freetype::freetype
        PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${FREETYPE_INCLUDE_DIRS}"
        IMPORTED_LOCATION "${FREETYPE_LIBRARIES}"
)
