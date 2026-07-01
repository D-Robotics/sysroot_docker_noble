#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "PySide2::pyside2" for configuration "RelWithDebInfo"
set_property(TARGET PySide2::pyside2 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(PySide2::pyside2 PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELWITHDEBINFO "Shiboken2::libshiboken;Qt5::Qml;Qt5::Core"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/aarch64-linux-gnu/libpyside2${PYTHON_CONFIG_SUFFIX}.so.5.15.13"
  IMPORTED_SONAME_RELWITHDEBINFO "libpyside2${PYTHON_CONFIG_SUFFIX}.so.5.15"
  )

list(APPEND _cmake_import_check_targets PySide2::pyside2 )
list(APPEND _cmake_import_check_files_for_PySide2::pyside2 "${_IMPORT_PREFIX}/aarch64-linux-gnu/libpyside2${PYTHON_CONFIG_SUFFIX}.so.5.15.13" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
