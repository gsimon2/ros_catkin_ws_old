#include <condition_variable>
#include <math.h>

#include <boost/thread.hpp>
#include <boost/algorithm/string.hpp>

#include <gazebo/gazebo_client.hh>
#include <gazebo/common/Plugin.hh>
#include <gazebo/msgs/msgs.hh>
#include <gazebo/transport/transport.hh>

#include <ros/ros.h>

#include <std_srvs/Empty.h>

#include <iostream>
#include <std_msgs/String.h>
#include <string>

ros::Publisher pub;
gazebo::transport::SubscriberPtr sub;

//void callback(gazebo::msgs::GzString &msg)
void callback(const std::string& msg)
{
	// gazebo::msgs::gzstring has 2 weird characters before the actaul data 
	//	that need to be stripped off
	std_msgs::String out_msg;
	out_msg.data = msg.substr(2);
	pub.publish(out_msg);
}

int main(int argc, char** argv)
{
	// Initialize the ROS Node (Client calls this service)
	ros::init(argc, argv, "region_event_server");
	ros::NodeHandle n;
	
	// Setup the Gazebo node that will step the simulation.
	gazebo::client::setup(argc,argv);
	gazebo::transport::NodePtr node(new gazebo::transport::Node());
	node->Init();
	
	// Setup subscriptions and publishers
	sub = node->Subscribe("~/region", callback); 
	pub = n.advertise<std_msgs::String>("ros_regions", 1000);

	ros::spin();
	
	return 0;
}

