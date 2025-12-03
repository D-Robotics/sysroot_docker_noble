# - Config file for the orocos-kdl package
# It defines the following variables
#  orocos_kdl_INCLUDE_DIRS - include directories for Orocos KDL
#  orocos_kdl_LIBRARIES    - libraries to link against for Orocos KDL
#  orocos_kdl_PKGCONFIG_DIR - directory containing the .pc pkgconfig files

# Find dependencies
find_package(Eigen3 QUIET)

set(KDL_USE_NEW_TREE_INTERFACE OFF)
if(KDL_USE_NEW_TREE_INTERFACE)
  find_package(Boost REQUIRED)
endif()

set(orocos_kdl_INCLUDE_DIRS
  ${Boost_INCLUDE_DIRS}
  ${EIGEN3_INCLUDE_DIR}
)
set(orocos_kdl_LIBRARIES orocos-kdl)

# where the .pc pkgconfig files are installed
set(orocos_kdl_PKGCONFIG_DIR "/usr/lib/aarch64-linux-gnu/pkgconfig")
