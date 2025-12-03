#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "GDCM::vtkgdcmPython" for configuration "None"
set_property(TARGET GDCM::vtkgdcmPython APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(GDCM::vtkgdcmPython PROPERTIES
  IMPORTED_COMMON_LANGUAGE_RUNTIME_NONE ""
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/python/dist-packages/vtkgdcm/vtkgdcm.cpython-312-aarch64-linux-gnu.so"
  IMPORTED_NO_SONAME_NONE "TRUE"
  )

list(APPEND _cmake_import_check_targets GDCM::vtkgdcmPython )
list(APPEND _cmake_import_check_files_for_GDCM::vtkgdcmPython "${_IMPORT_PREFIX}/lib/python/dist-packages/vtkgdcm/vtkgdcm.cpython-312-aarch64-linux-gnu.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
