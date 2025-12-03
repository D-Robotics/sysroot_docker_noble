#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "uriparser::uriparser" for configuration "None"
set_property(TARGET uriparser::uriparser APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(uriparser::uriparser PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/liburiparser.so.1.0.30"
  IMPORTED_SONAME_NONE "liburiparser.so.1"
  )

list(APPEND _cmake_import_check_targets uriparser::uriparser )
list(APPEND _cmake_import_check_files_for_uriparser::uriparser "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/liburiparser.so.1.0.30" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
