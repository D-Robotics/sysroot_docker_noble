#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "superlu::superlu" for configuration "None"
set_property(TARGET superlu::superlu APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(superlu::superlu PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libsuperlu.so.6.0.1"
  IMPORTED_SONAME_NONE "libsuperlu.so.6"
  )

list(APPEND _cmake_import_check_targets superlu::superlu )
list(APPEND _cmake_import_check_files_for_superlu::superlu "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libsuperlu.so.6.0.1" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
