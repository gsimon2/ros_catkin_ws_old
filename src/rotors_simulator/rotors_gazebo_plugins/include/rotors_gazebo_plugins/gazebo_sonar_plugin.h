#ifndef ROTORS_GAZEBO_PLUGINS_SONAR_PLUGIN_H
#define ROTORS_GAZEBO_PLUGINS_SONAR_PLUGIN_H

#include <sensor_msgs/Range.h>
#include <random>

#include <Eigen/Core>
#include <gazebo/common/common.hh>
#include <gazebo/common/Plugin.hh>
#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <ros/callback_queue.h>
#include <ros/ros.h>
#include <sensor_msgs/Imu.h>

#include "rotors_gazebo_plugins/common.h"

namespace gazebo
{

class GazeboSonarPlugin : public SensorPlugin
{
public:
  GazeboSonarPlugin();
  ~GazeboSonarPlugin();
  
  void InitializeParams();
  void Publish();

protected:
  void Load(sensors::SensorPtr _sensor, sdf::ElementPtr _sdf);

  void OnUpdate(const common::UpdateInfo&);

private:
  /// \brief The parent World
  physics::WorldPtr world;

  // Pointer to the link
  physics::LinkPtr link_;
  
  common::Time last_time_;
  
  sensors::RaySensorPtr sensor_;

  ros::NodeHandle* node_handle_;
  ros::Publisher publisher_;

  sensor_msgs::Range range_;

  std::string namespace_;
  std::string topic_;
  std::string frame_id_;

  event::ConnectionPtr updateConnection;
};

} // namespace gazebo

#endif // ROTORS_GAZEBO_PLUGINS_SONAR_PLUGIN_H
