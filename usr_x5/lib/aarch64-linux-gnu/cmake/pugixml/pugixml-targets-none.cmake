#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "pugixml::shared" for configuration "None"
set_property(TARGET pugixml::shared APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(pugixml::shared PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libpugixml.so.1.14"
  IMPORTED_SONAME_NONE "libpugixml.so.1"
  )

list(APPEND _cmake_import_check_targets pugixml::shared )
list(APPEND _cmake_import_check_files_for_pugixml::shared "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libpugixml.so.1.14" )

# Import target "pugixml::static" for configuration "None"
set_property(TARGET pugixml::static APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(pugixml::static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NONE "CXX"
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libpugixml.a"
  )

list(APPEND _cmake_import_check_targets pugixml::static )
list(APPEND _cmake_import_check_files_for_pugixml::static "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libpugixml.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
