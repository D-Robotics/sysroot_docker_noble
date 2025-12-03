#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Shiboken2::libshiboken" for configuration "RelWithDebInfo"
set_property(TARGET Shiboken2::libshiboken APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(Shiboken2::libshiboken PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/aarch64-linux-gnu/libshiboken2${PYTHON_CONFIG_SUFFIX}.so.5.15.13"
  IMPORTED_SONAME_RELWITHDEBINFO "libshiboken2${PYTHON_CONFIG_SUFFIX}.so.5.15"
  )

list(APPEND _cmake_import_check_targets Shiboken2::libshiboken )
list(APPEND _cmake_import_check_files_for_Shiboken2::libshiboken "${_IMPORT_PREFIX}/aarch64-linux-gnu/libshiboken2${PYTHON_CONFIG_SUFFIX}.so.5.15.13" )

# Import target "Shiboken2::shiboken2" for configuration "RelWithDebInfo"
set_property(TARGET Shiboken2::shiboken2 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(Shiboken2::shiboken2 PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "/usr/bin/shiboken2"
  )

list(APPEND _cmake_import_check_targets Shiboken2::shiboken2 )
list(APPEND _cmake_import_check_files_for_Shiboken2::shiboken2 "/usr/bin/shiboken2" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
