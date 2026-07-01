#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Qhull::qhullcpp" for configuration "None"
set_property(TARGET Qhull::qhullcpp APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(Qhull::qhullcpp PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libqhullcpp.so.8.0.2"
  IMPORTED_SONAME_NONE "libqhullcpp.so.8.0"
  )

list(APPEND _cmake_import_check_targets Qhull::qhullcpp )
list(APPEND _cmake_import_check_files_for_Qhull::qhullcpp "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libqhullcpp.so.8.0.2" )

# Import target "Qhull::qhull_r" for configuration "None"
set_property(TARGET Qhull::qhull_r APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(Qhull::qhull_r PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libqhull_r.so.8.0.2"
  IMPORTED_SONAME_NONE "libqhull_r.so.8.0"
  )

list(APPEND _cmake_import_check_targets Qhull::qhull_r )
list(APPEND _cmake_import_check_files_for_Qhull::qhull_r "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libqhull_r.so.8.0.2" )

# Import target "Qhull::libqhull" for configuration "None"
set_property(TARGET Qhull::libqhull APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(Qhull::libqhull PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libqhull.so.8.0.2"
  IMPORTED_SONAME_NONE "libqhull.so.8.0"
  )

list(APPEND _cmake_import_check_targets Qhull::libqhull )
list(APPEND _cmake_import_check_files_for_Qhull::libqhull "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libqhull.so.8.0.2" )

# Import target "Qhull::qhullcpp_static" for configuration "None"
set_property(TARGET Qhull::qhullcpp_static APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(Qhull::qhullcpp_static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NONE "CXX"
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libqhullcpp.a"
  )

list(APPEND _cmake_import_check_targets Qhull::qhullcpp_static )
list(APPEND _cmake_import_check_files_for_Qhull::qhullcpp_static "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libqhullcpp.a" )

# Import target "Qhull::qhullstatic" for configuration "None"
set_property(TARGET Qhull::qhullstatic APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(Qhull::qhullstatic PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NONE "C"
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libqhullstatic.a"
  )

list(APPEND _cmake_import_check_targets Qhull::qhullstatic )
list(APPEND _cmake_import_check_files_for_Qhull::qhullstatic "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libqhullstatic.a" )

# Import target "Qhull::qhullstatic_r" for configuration "None"
set_property(TARGET Qhull::qhullstatic_r APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(Qhull::qhullstatic_r PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NONE "C"
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libqhullstatic_r.a"
  )

list(APPEND _cmake_import_check_targets Qhull::qhullstatic_r )
list(APPEND _cmake_import_check_files_for_Qhull::qhullstatic_r "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libqhullstatic_r.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
