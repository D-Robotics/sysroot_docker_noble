#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "GDCM::vtkgdcm" for configuration "None"
set_property(TARGET GDCM::vtkgdcm APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(GDCM::vtkgdcm PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NONE "VTK::CommonMisc;VTK::ImagingCore;VTK::IOCore;VTK::InteractionStyle;VTK::RenderingCore;gdcmMSFF"
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libvtkgdcm-9.1.so.3.0.22"
  IMPORTED_SONAME_NONE "libvtkgdcm-9.1.so.1"
  )

list(APPEND _cmake_import_check_targets GDCM::vtkgdcm )
list(APPEND _cmake_import_check_files_for_GDCM::vtkgdcm "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libvtkgdcm-9.1.so.3.0.22" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
