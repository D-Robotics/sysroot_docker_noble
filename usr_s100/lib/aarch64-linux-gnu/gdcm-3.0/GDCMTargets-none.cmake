#----------------------------------------------------------------
# Generated CMake target import file for configuration "None".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "gdcmjpeg8" for configuration "None"
set_property(TARGET gdcmjpeg8 APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmjpeg8 PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libgdcmjpeg8.so.3.0.22"
  IMPORTED_SONAME_NONE "libgdcmjpeg8.so.3.0"
  )

list(APPEND _cmake_import_check_targets gdcmjpeg8 )
list(APPEND _cmake_import_check_files_for_gdcmjpeg8 "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libgdcmjpeg8.so.3.0.22" )

# Import target "gdcmjpeg12" for configuration "None"
set_property(TARGET gdcmjpeg12 APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmjpeg12 PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libgdcmjpeg12.so.3.0.22"
  IMPORTED_SONAME_NONE "libgdcmjpeg12.so.3.0"
  )

list(APPEND _cmake_import_check_targets gdcmjpeg12 )
list(APPEND _cmake_import_check_files_for_gdcmjpeg12 "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libgdcmjpeg12.so.3.0.22" )

# Import target "gdcmjpeg16" for configuration "None"
set_property(TARGET gdcmjpeg16 APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmjpeg16 PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libgdcmjpeg16.so.3.0.22"
  IMPORTED_SONAME_NONE "libgdcmjpeg16.so.3.0"
  )

list(APPEND _cmake_import_check_targets gdcmjpeg16 )
list(APPEND _cmake_import_check_files_for_gdcmjpeg16 "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libgdcmjpeg16.so.3.0.22" )

# Import target "gdcmCommon" for configuration "None"
set_property(TARGET gdcmCommon APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmCommon PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libgdcmCommon.so.3.0.22"
  IMPORTED_SONAME_NONE "libgdcmCommon.so.3.0"
  )

list(APPEND _cmake_import_check_targets gdcmCommon )
list(APPEND _cmake_import_check_files_for_gdcmCommon "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libgdcmCommon.so.3.0.22" )

# Import target "gdcmDICT" for configuration "None"
set_property(TARGET gdcmDICT APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmDICT PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NONE "gdcmDSED;gdcmIOD"
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libgdcmDICT.so.3.0.22"
  IMPORTED_SONAME_NONE "libgdcmDICT.so.3.0"
  )

list(APPEND _cmake_import_check_targets gdcmDICT )
list(APPEND _cmake_import_check_files_for_gdcmDICT "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libgdcmDICT.so.3.0.22" )

# Import target "gdcmDSED" for configuration "None"
set_property(TARGET gdcmDSED APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmDSED PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libgdcmDSED.so.3.0.22"
  IMPORTED_SONAME_NONE "libgdcmDSED.so.3.0"
  )

list(APPEND _cmake_import_check_targets gdcmDSED )
list(APPEND _cmake_import_check_files_for_gdcmDSED "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libgdcmDSED.so.3.0.22" )

# Import target "gdcmIOD" for configuration "None"
set_property(TARGET gdcmIOD APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmIOD PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libgdcmIOD.so.3.0.22"
  IMPORTED_SONAME_NONE "libgdcmIOD.so.3.0"
  )

list(APPEND _cmake_import_check_targets gdcmIOD )
list(APPEND _cmake_import_check_files_for_gdcmIOD "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libgdcmIOD.so.3.0.22" )

# Import target "gdcmMSFF" for configuration "None"
set_property(TARGET gdcmMSFF APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmMSFF PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NONE "gdcmjpeg8;gdcmjpeg12;gdcmjpeg16;charls"
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libgdcmMSFF.so.3.0.22"
  IMPORTED_SONAME_NONE "libgdcmMSFF.so.3.0"
  )

list(APPEND _cmake_import_check_targets gdcmMSFF )
list(APPEND _cmake_import_check_files_for_gdcmMSFF "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libgdcmMSFF.so.3.0.22" )

# Import target "gdcmMEXD" for configuration "None"
set_property(TARGET gdcmMEXD APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmMEXD PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_NONE "gdcmMSFF;gdcmDICT;gdcmDSED;gdcmIOD"
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libgdcmMEXD.so.3.0.22"
  IMPORTED_SONAME_NONE "libgdcmMEXD.so.3.0"
  )

list(APPEND _cmake_import_check_targets gdcmMEXD )
list(APPEND _cmake_import_check_files_for_gdcmMEXD "${_IMPORT_PREFIX}/lib/aarch64-linux-gnu/libgdcmMEXD.so.3.0.22" )

# Import target "gdcmdump" for configuration "None"
set_property(TARGET gdcmdump APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmdump PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/bin/gdcmdump"
  )

list(APPEND _cmake_import_check_targets gdcmdump )
list(APPEND _cmake_import_check_files_for_gdcmdump "${_IMPORT_PREFIX}/bin/gdcmdump" )

# Import target "gdcmdiff" for configuration "None"
set_property(TARGET gdcmdiff APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmdiff PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/bin/gdcmdiff"
  )

list(APPEND _cmake_import_check_targets gdcmdiff )
list(APPEND _cmake_import_check_files_for_gdcmdiff "${_IMPORT_PREFIX}/bin/gdcmdiff" )

# Import target "gdcmraw" for configuration "None"
set_property(TARGET gdcmraw APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmraw PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/bin/gdcmraw"
  )

list(APPEND _cmake_import_check_targets gdcmraw )
list(APPEND _cmake_import_check_files_for_gdcmraw "${_IMPORT_PREFIX}/bin/gdcmraw" )

# Import target "gdcmscanner" for configuration "None"
set_property(TARGET gdcmscanner APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmscanner PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/bin/gdcmscanner"
  )

list(APPEND _cmake_import_check_targets gdcmscanner )
list(APPEND _cmake_import_check_files_for_gdcmscanner "${_IMPORT_PREFIX}/bin/gdcmscanner" )

# Import target "gdcmanon" for configuration "None"
set_property(TARGET gdcmanon APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmanon PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/bin/gdcmanon"
  )

list(APPEND _cmake_import_check_targets gdcmanon )
list(APPEND _cmake_import_check_files_for_gdcmanon "${_IMPORT_PREFIX}/bin/gdcmanon" )

# Import target "gdcmclean" for configuration "None"
set_property(TARGET gdcmclean APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmclean PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/bin/gdcmclean"
  )

list(APPEND _cmake_import_check_targets gdcmclean )
list(APPEND _cmake_import_check_files_for_gdcmclean "${_IMPORT_PREFIX}/bin/gdcmclean" )

# Import target "gdcmgendir" for configuration "None"
set_property(TARGET gdcmgendir APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmgendir PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/bin/gdcmgendir"
  )

list(APPEND _cmake_import_check_targets gdcmgendir )
list(APPEND _cmake_import_check_files_for_gdcmgendir "${_IMPORT_PREFIX}/bin/gdcmgendir" )

# Import target "gdcmimg" for configuration "None"
set_property(TARGET gdcmimg APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmimg PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/bin/gdcmimg"
  )

list(APPEND _cmake_import_check_targets gdcmimg )
list(APPEND _cmake_import_check_files_for_gdcmimg "${_IMPORT_PREFIX}/bin/gdcmimg" )

# Import target "gdcmconv" for configuration "None"
set_property(TARGET gdcmconv APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmconv PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/bin/gdcmconv"
  )

list(APPEND _cmake_import_check_targets gdcmconv )
list(APPEND _cmake_import_check_files_for_gdcmconv "${_IMPORT_PREFIX}/bin/gdcmconv" )

# Import target "gdcmtar" for configuration "None"
set_property(TARGET gdcmtar APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmtar PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/bin/gdcmtar"
  )

list(APPEND _cmake_import_check_targets gdcmtar )
list(APPEND _cmake_import_check_files_for_gdcmtar "${_IMPORT_PREFIX}/bin/gdcmtar" )

# Import target "gdcminfo" for configuration "None"
set_property(TARGET gdcminfo APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcminfo PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/bin/gdcminfo"
  )

list(APPEND _cmake_import_check_targets gdcminfo )
list(APPEND _cmake_import_check_files_for_gdcminfo "${_IMPORT_PREFIX}/bin/gdcminfo" )

# Import target "gdcmscu" for configuration "None"
set_property(TARGET gdcmscu APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmscu PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/bin/gdcmscu"
  )

list(APPEND _cmake_import_check_targets gdcmscu )
list(APPEND _cmake_import_check_files_for_gdcmscu "${_IMPORT_PREFIX}/bin/gdcmscu" )

# Import target "gdcmxml" for configuration "None"
set_property(TARGET gdcmxml APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmxml PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/bin/gdcmxml"
  )

list(APPEND _cmake_import_check_targets gdcmxml )
list(APPEND _cmake_import_check_files_for_gdcmxml "${_IMPORT_PREFIX}/bin/gdcmxml" )

# Import target "gdcmpap3" for configuration "None"
set_property(TARGET gdcmpap3 APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmpap3 PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/bin/gdcmpap3"
  )

list(APPEND _cmake_import_check_targets gdcmpap3 )
list(APPEND _cmake_import_check_files_for_gdcmpap3 "${_IMPORT_PREFIX}/bin/gdcmpap3" )

# Import target "gdcmpdf" for configuration "None"
set_property(TARGET gdcmpdf APPEND PROPERTY IMPORTED_CONFIGURATIONS NONE)
set_target_properties(gdcmpdf PROPERTIES
  IMPORTED_LOCATION_NONE "${_IMPORT_PREFIX}/bin/gdcmpdf"
  )

list(APPEND _cmake_import_check_targets gdcmpdf )
list(APPEND _cmake_import_check_files_for_gdcmpdf "${_IMPORT_PREFIX}/bin/gdcmpdf" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
