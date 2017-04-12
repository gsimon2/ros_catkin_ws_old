# Install script for directory: /home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "/home/simongle/simulation/ros_catkin_ws/install")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

# Install shared libraries without execute permission?
IF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  SET(CMAKE_INSTALL_SO_NO_EXE "1")
ENDIF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ardupilot_sitl_gazebo_plugin/srv" TYPE FILE FILES
    "/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/srv/ReleaseApmLapseLock.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/srv/TakeApmLapseLock.srv"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ardupilot_sitl_gazebo_plugin/cmake" TYPE FILE FILES "/home/simongle/simulation/ros_catkin_ws/build/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/catkin_generated/installspace/ardupilot_sitl_gazebo_plugin-msg-paths.cmake")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/simongle/simulation/ros_catkin_ws/devel/include/ardupilot_sitl_gazebo_plugin")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/simongle/simulation/ros_catkin_ws/devel/share/common-lisp/ros/ardupilot_sitl_gazebo_plugin")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/usr/bin/python" -m compileall "/home/simongle/simulation/ros_catkin_ws/devel/lib/python2.7/dist-packages/ardupilot_sitl_gazebo_plugin")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/simongle/simulation/ros_catkin_ws/devel/lib/python2.7/dist-packages/ardupilot_sitl_gazebo_plugin")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/simongle/simulation/ros_catkin_ws/build/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/catkin_generated/installspace/ardupilot_sitl_gazebo_plugin.pc")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ardupilot_sitl_gazebo_plugin/cmake" TYPE FILE FILES "/home/simongle/simulation/ros_catkin_ws/build/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/catkin_generated/installspace/ardupilot_sitl_gazebo_plugin-msg-extras.cmake")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ardupilot_sitl_gazebo_plugin/cmake" TYPE FILE FILES
    "/home/simongle/simulation/ros_catkin_ws/build/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/catkin_generated/installspace/ardupilot_sitl_gazebo_pluginConfig.cmake"
    "/home/simongle/simulation/ros_catkin_ws/build/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/catkin_generated/installspace/ardupilot_sitl_gazebo_pluginConfig-version.cmake"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ardupilot_sitl_gazebo_plugin" TYPE FILE FILES "/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/package.xml")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

