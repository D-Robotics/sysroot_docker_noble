#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "log4cxx" for configuration "None"
set_property(TARGET log4cxx APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(log4cxx PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/liblog4cxx.so.15.1.0"
  IMPORTED_SONAME_NONE "liblog4cxx.so.15"
  )

list(APPEND _cmake_import_check_targets log4cxx )
list(APPEND _cmake_import_check_files_for_log4cxx "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/liblog4cxx.so.15.1.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
