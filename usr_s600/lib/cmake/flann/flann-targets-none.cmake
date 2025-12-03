#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "flann::flann_cpp" for configuration "None"
set_property(TARGET flann::flann_cpp APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(flann::flann_cpp PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_NONE "-Wl,-whole-archive;flann::flann_cpp_s;-Wl,-no-whole-archive"
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libflann_cpp.so.1.9.2"
  IMPORTED_SONAME_NONE "libflann_cpp.so.1.9"
  )

list(APPEND _cmake_import_check_targets flann::flann_cpp )
list(APPEND _cmake_import_check_files_for_flann::flann_cpp "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libflann_cpp.so.1.9.2" )

# Import target "flann::flann_cpp_s" for configuration "None"
set_property(TARGET flann::flann_cpp_s APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(flann::flann_cpp_s PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NONE "CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_NONE "/usr/lib/aarch64-linux-gnu/liblz4.so"
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libflann_cpp_s.a"
  )

list(APPEND _cmake_import_check_targets flann::flann_cpp_s )
list(APPEND _cmake_import_check_files_for_flann::flann_cpp_s "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libflann_cpp_s.a" )

# Import target "flann::flann" for configuration "None"
set_property(TARGET flann::flann APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(flann::flann PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_NONE "-Wl,-whole-archive;flann::flann_s;-Wl,-no-whole-archive"
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libflann.so.1.9.2"
  IMPORTED_SONAME_NONE "libflann.so.1.9"
  )

list(APPEND _cmake_import_check_targets flann::flann )
list(APPEND _cmake_import_check_files_for_flann::flann "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libflann.so.1.9.2" )

# Import target "flann::flann_s" for configuration "None"
set_property(TARGET flann::flann_s APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(flann::flann_s PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NONE "CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES_NONE "/usr/lib/aarch64-linux-gnu/liblz4.so"
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libflann_s.a"
  )

list(APPEND _cmake_import_check_targets flann::flann_s )
list(APPEND _cmake_import_check_files_for_flann::flann_s "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libflann_s.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
