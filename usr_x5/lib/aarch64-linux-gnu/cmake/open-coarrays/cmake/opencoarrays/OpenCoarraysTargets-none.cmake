#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "OpenCoarrays::opencoarrays_mod" for configuration "None"
set_property(TARGET OpenCoarrays::opencoarrays_mod APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(OpenCoarrays::opencoarrays_mod PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NONE "Fortran"
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libopencoarrays_mod.a"
  )

list(APPEND _cmake_import_check_targets OpenCoarrays::opencoarrays_mod )
list(APPEND _cmake_import_check_files_for_OpenCoarrays::opencoarrays_mod "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libopencoarrays_mod.a" )

# Import target "OpenCoarrays::caf_openmpi" for configuration "None"
set_property(TARGET OpenCoarrays::caf_openmpi APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(OpenCoarrays::caf_openmpi PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libcaf_openmpi.so.3"
  IMPORTED_SONAME_NONE "libcaf_openmpi.so.3"
  )

list(APPEND _cmake_import_check_targets OpenCoarrays::caf_openmpi )
list(APPEND _cmake_import_check_files_for_OpenCoarrays::caf_openmpi "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libcaf_openmpi.so.3" )

# Import target "OpenCoarrays::caf_mpi_static" for configuration "None"
set_property(TARGET OpenCoarrays::caf_mpi_static APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(OpenCoarrays::caf_mpi_static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NONE "C"
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libcaf_openmpi.a"
  )

list(APPEND _cmake_import_check_targets OpenCoarrays::caf_mpi_static )
list(APPEND _cmake_import_check_files_for_OpenCoarrays::caf_mpi_static "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libcaf_openmpi.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
