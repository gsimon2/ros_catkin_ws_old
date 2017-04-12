# Install script for directory: /home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs

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
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gazebo_msgs/msg" TYPE FILE FILES
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/msg/ContactsState.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/msg/ContactState.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/msg/LinkState.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/msg/LinkStates.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/msg/ModelState.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/msg/ModelStates.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/msg/ODEJointProperties.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/msg/ODEPhysics.msg"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/msg/WorldState.msg"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gazebo_msgs/srv" TYPE FILE FILES
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/ApplyBodyWrench.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/DeleteModel.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/GetLinkState.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/GetPhysicsProperties.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/SetJointProperties.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/SetModelConfiguration.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/SpawnModel.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/ApplyJointEffort.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/GetJointProperties.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/GetModelProperties.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/GetWorldProperties.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/SetLinkProperties.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/SetModelState.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/BodyRequest.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/GetLinkProperties.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/GetModelState.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/JointRequest.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/SetLinkState.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/SetPhysicsProperties.srv"
    "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/srv/SetJointTrajectory.srv"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gazebo_msgs/cmake" TYPE FILE FILES "/home/simongle/simulation/ros_catkin_ws/build/gazebo_ros_pkgs/gazebo_msgs/catkin_generated/installspace/gazebo_msgs-msg-paths.cmake")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/simongle/simulation/ros_catkin_ws/devel/include/gazebo_msgs")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/simongle/simulation/ros_catkin_ws/devel/share/common-lisp/ros/gazebo_msgs")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/usr/bin/python" -m compileall "/home/simongle/simulation/ros_catkin_ws/devel/lib/python2.7/dist-packages/gazebo_msgs")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/simongle/simulation/ros_catkin_ws/devel/lib/python2.7/dist-packages/gazebo_msgs")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/simongle/simulation/ros_catkin_ws/build/gazebo_ros_pkgs/gazebo_msgs/catkin_generated/installspace/gazebo_msgs.pc")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gazebo_msgs/cmake" TYPE FILE FILES "/home/simongle/simulation/ros_catkin_ws/build/gazebo_ros_pkgs/gazebo_msgs/catkin_generated/installspace/gazebo_msgs-msg-extras.cmake")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gazebo_msgs/cmake" TYPE FILE FILES
    "/home/simongle/simulation/ros_catkin_ws/build/gazebo_ros_pkgs/gazebo_msgs/catkin_generated/installspace/gazebo_msgsConfig.cmake"
    "/home/simongle/simulation/ros_catkin_ws/build/gazebo_ros_pkgs/gazebo_msgs/catkin_generated/installspace/gazebo_msgsConfig-version.cmake"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gazebo_msgs" TYPE FILE FILES "/home/simongle/simulation/ros_catkin_ws/src/gazebo_ros_pkgs/gazebo_msgs/package.xml")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

