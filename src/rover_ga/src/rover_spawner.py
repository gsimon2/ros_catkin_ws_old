#!/usr/bin/env python

import rospy, tf
from gazebo_msgs.srv import DeleteModel, SpawnModel
from geometry_msgs.msg import *

print("Waiting for gazebo services...")
rospy.init_node("Custom Rover Spawner")
rospy.wait_for_service("gazebo/delete_model")
rospy.wait_for_service("gazebo/spawn_urdf_model")
print("Got it.")
delete_model = rospy.ServiceProxy("gazebo/delete_model", DeleteModel)
spawn_model = rospy.ServiceProxy("gazebo/spawn_urdf_model", SpawnModel)


delete_model("rover")

with open("/home/simongle/simulation/ros_catkin_ws/src/ardupilot_sitl_gazebo_plugin/ardupilot_sitl_gazebo_plugin/urdf/rover.urdf", "r") as f:
	product_xml = f.read()


orient = Quaternion(*tf.transformations.quaternion_from_euler(0,0,0))
item_pose = Pose(Point(0,0,0), orient)

spawn_model("rover", product_xml, "", item_pose, "world")
