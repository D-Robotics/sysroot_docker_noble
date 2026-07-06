#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "PROJ::proj" for configuration "None"
set_property(TARGET PROJ::proj APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(PROJ::proj PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libproj.so.25.9.4.0"
  IMPORTED_SONAME_NONE "libproj.so.25"
  )

list(APPEND _cmake_import_check_targets PROJ::proj )
list(APPEND _cmake_import_check_files_for_PROJ::proj "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libproj.so.25.9.4.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
