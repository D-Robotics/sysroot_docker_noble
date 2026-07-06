#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "VTK::vtkjava" for configuration "RelWithDebInfo"
set_property(TARGET VTK::vtkjava APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(VTK::vtkjava PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELWITHDEBINFO "Java"
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/java/vtk.jar"
  )

list(APPEND _cmake_import_check_targets VTK::vtkjava )
list(APPEND _cmake_import_check_files_for_VTK::vtkjava "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/java/vtk.jar" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
