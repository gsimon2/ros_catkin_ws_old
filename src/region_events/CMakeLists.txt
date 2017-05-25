cmake_minimum_required(VERSION 2.8.3)
project(region_events)

## Add support for C++11, supported in ROS Kinetic and newer
add_definitions(-std=c++11)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  rospy
  gazebo_ros
  message_generation
  message_runtime
  roscpp
)

find_package(gazebo REQUIRED)

catkin_python_setup()

## Generate messages in the 'msg' folder
# add_message_files(
#   FILES
#   Message1.msg
#   Message2.msg
# )

## Generate services in the 'srv' folder
add_service_files(
   FILES
   region_events.srv
#   Service2.srv
)

generate_messages(
   DEPENDENCIES
   std_msgs  # Or other packages containing msgs
)

catkin_package(
)

include_directories(
  ${catkin_INCLUDE_DIRS}
  ${Boost_INCLUDE_DIR}
  ${GAZEBO_INCLUDE_DIRS}
)

add_executable(${PROJECT_NAME}_node src/region_events.cpp)

target_link_libraries(${PROJECT_NAME}_node ${catkin_LIBRARIES}
${GAZEBO_LIBRARIES})
add_dependencies(${PROJECT_NAME}_node region_events_gencpp)
