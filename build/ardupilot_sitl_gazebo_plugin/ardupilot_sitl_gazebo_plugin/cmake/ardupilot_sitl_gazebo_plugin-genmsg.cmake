# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "ardupilot_sitl_gazebo_plugin: 0 messages, 2 services")

set(MSG_I_FLAGS "-Istd_msgs:/opt/ros/indigo/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(ardupilot_sitl_gazebo_plugin_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/srv/ReleaseApmLapseLock.srv" NAME_WE)
add_custom_target(_ardupilot_sitl_gazebo_plugin_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "ardupilot_sitl_gazebo_plugin" "/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/srv/ReleaseApmLapseLock.srv" ""
)

get_filename_component(_filename "/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/srv/TakeApmLapseLock.srv" NAME_WE)
add_custom_target(_ardupilot_sitl_gazebo_plugin_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "ardupilot_sitl_gazebo_plugin" "/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/srv/TakeApmLapseLock.srv" ""
)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(ardupilot_sitl_gazebo_plugin
  "/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/srv/ReleaseApmLapseLock.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ardupilot_sitl_gazebo_plugin
)
_generate_srv_cpp(ardupilot_sitl_gazebo_plugin
  "/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/srv/TakeApmLapseLock.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ardupilot_sitl_gazebo_plugin
)

### Generating Module File
_generate_module_cpp(ardupilot_sitl_gazebo_plugin
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ardupilot_sitl_gazebo_plugin
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(ardupilot_sitl_gazebo_plugin_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(ardupilot_sitl_gazebo_plugin_generate_messages ardupilot_sitl_gazebo_plugin_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/srv/ReleaseApmLapseLock.srv" NAME_WE)
add_dependencies(ardupilot_sitl_gazebo_plugin_generate_messages_cpp _ardupilot_sitl_gazebo_plugin_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/srv/TakeApmLapseLock.srv" NAME_WE)
add_dependencies(ardupilot_sitl_gazebo_plugin_generate_messages_cpp _ardupilot_sitl_gazebo_plugin_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ardupilot_sitl_gazebo_plugin_gencpp)
add_dependencies(ardupilot_sitl_gazebo_plugin_gencpp ardupilot_sitl_gazebo_plugin_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ardupilot_sitl_gazebo_plugin_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(ardupilot_sitl_gazebo_plugin
  "/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/srv/ReleaseApmLapseLock.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ardupilot_sitl_gazebo_plugin
)
_generate_srv_lisp(ardupilot_sitl_gazebo_plugin
  "/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/srv/TakeApmLapseLock.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ardupilot_sitl_gazebo_plugin
)

### Generating Module File
_generate_module_lisp(ardupilot_sitl_gazebo_plugin
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ardupilot_sitl_gazebo_plugin
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(ardupilot_sitl_gazebo_plugin_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(ardupilot_sitl_gazebo_plugin_generate_messages ardupilot_sitl_gazebo_plugin_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/srv/ReleaseApmLapseLock.srv" NAME_WE)
add_dependencies(ardupilot_sitl_gazebo_plugin_generate_messages_lisp _ardupilot_sitl_gazebo_plugin_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/srv/TakeApmLapseLock.srv" NAME_WE)
add_dependencies(ardupilot_sitl_gazebo_plugin_generate_messages_lisp _ardupilot_sitl_gazebo_plugin_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ardupilot_sitl_gazebo_plugin_genlisp)
add_dependencies(ardupilot_sitl_gazebo_plugin_genlisp ardupilot_sitl_gazebo_plugin_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ardupilot_sitl_gazebo_plugin_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(ardupilot_sitl_gazebo_plugin
  "/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/srv/ReleaseApmLapseLock.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ardupilot_sitl_gazebo_plugin
)
_generate_srv_py(ardupilot_sitl_gazebo_plugin
  "/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/srv/TakeApmLapseLock.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ardupilot_sitl_gazebo_plugin
)

### Generating Module File
_generate_module_py(ardupilot_sitl_gazebo_plugin
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ardupilot_sitl_gazebo_plugin
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(ardupilot_sitl_gazebo_plugin_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(ardupilot_sitl_gazebo_plugin_generate_messages ardupilot_sitl_gazebo_plugin_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/srv/ReleaseApmLapseLock.srv" NAME_WE)
add_dependencies(ardupilot_sitl_gazebo_plugin_generate_messages_py _ardupilot_sitl_gazebo_plugin_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/srv/TakeApmLapseLock.srv" NAME_WE)
add_dependencies(ardupilot_sitl_gazebo_plugin_generate_messages_py _ardupilot_sitl_gazebo_plugin_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ardupilot_sitl_gazebo_plugin_genpy)
add_dependencies(ardupilot_sitl_gazebo_plugin_genpy ardupilot_sitl_gazebo_plugin_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ardupilot_sitl_gazebo_plugin_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ardupilot_sitl_gazebo_plugin)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ardupilot_sitl_gazebo_plugin
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(ardupilot_sitl_gazebo_plugin_generate_messages_cpp std_msgs_generate_messages_cpp)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ardupilot_sitl_gazebo_plugin)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ardupilot_sitl_gazebo_plugin
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(ardupilot_sitl_gazebo_plugin_generate_messages_lisp std_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ardupilot_sitl_gazebo_plugin)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ardupilot_sitl_gazebo_plugin\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ardupilot_sitl_gazebo_plugin
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(ardupilot_sitl_gazebo_plugin_generate_messages_py std_msgs_generate_messages_py)
