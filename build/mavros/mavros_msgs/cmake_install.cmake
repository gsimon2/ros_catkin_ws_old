# Install script for directory: /home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs

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
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/mavros_msgs/msg" TYPE FILE FILES
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/ActuatorControl.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/Altitude.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/AttitudeTarget.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/BatteryStatus.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/CamIMUStamp.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/CommandCode.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/ExtendedState.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/FileEntry.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/GlobalPositionTarget.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/HomePosition.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/ManualControl.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/Mavlink.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/OpticalFlowRad.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/OverrideRCIn.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/ParamValue.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/PositionTarget.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/RCIn.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/RCOut.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/RadioStatus.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/State.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/VFR_HUD.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/Vibration.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/Waypoint.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/msg/WaypointList.msg"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/mavros_msgs/srv" TYPE FILE FILES
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/CommandBool.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/CommandHome.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/CommandInt.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/CommandLong.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/CommandTOL.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/CommandTriggerControl.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/FileChecksum.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/FileClose.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/FileList.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/FileMakeDir.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/FileOpen.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/FileRead.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/FileRemove.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/FileRemoveDir.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/FileRename.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/FileTruncate.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/FileWrite.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/ParamGet.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/ParamPull.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/ParamPush.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/ParamSet.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/SetMode.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/StreamRate.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/WaypointClear.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/WaypointPull.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/WaypointPush.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/srv/WaypointSetCurrent.srv"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/mavros_msgs/cmake" TYPE FILE FILES "/home/simongle/simulation/ros_catkin_ws/build/mavros/mavros_msgs/catkin_generated/installspace/mavros_msgs-msg-paths.cmake")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/simongle/simulation/ros_catkin_ws/devel/include/mavros_msgs")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/simongle/simulation/ros_catkin_ws/devel/share/common-lisp/ros/mavros_msgs")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/usr/bin/python" -m compileall "/home/simongle/simulation/ros_catkin_ws/devel/lib/python2.7/dist-packages/mavros_msgs")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/simongle/simulation/ros_catkin_ws/devel/lib/python2.7/dist-packages/mavros_msgs")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/simongle/simulation/ros_catkin_ws/build/mavros/mavros_msgs/catkin_generated/installspace/mavros_msgs.pc")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/mavros_msgs/cmake" TYPE FILE FILES "/home/simongle/simulation/ros_catkin_ws/build/mavros/mavros_msgs/catkin_generated/installspace/mavros_msgs-msg-extras.cmake")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/mavros_msgs/cmake" TYPE FILE FILES
    "/home/simongle/simulation/ros_catkin_ws/build/mavros/mavros_msgs/catkin_generated/installspace/mavros_msgsConfig.cmake"
    "/home/simongle/simulation/ros_catkin_ws/build/mavros/mavros_msgs/catkin_generated/installspace/mavros_msgsConfig-version.cmake"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/mavros_msgs" TYPE FILE FILES "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/package.xml")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/mavros_msgs" TYPE DIRECTORY FILES "/home/simongle/simulation/ros_catkin_ws/src/mavros/mavros_msgs/include/mavros_msgs/" FILES_MATCHING REGEX "/[^/]*\\.h$")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

