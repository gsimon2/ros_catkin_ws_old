//=================================================================================================
// Copyright (c) 2012, Johannes Meyer, TU Darmstadt
// All rights reserved.

// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the Flight Systems and Automatic Control group,
//       TU Darmstadt, nor the names of its contributors may be used to
//       endorse or promote products derived from this software without
//       specific prior written permission.

// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//=================================================================================================

#include "rotors_gazebo_plugins/gazebo_sonar_plugin.h"
#include <gazebo/physics/physics.hh>
#include <gazebo/sensors/RaySensor.hh>

#include <limits>

#include <chrono>
#include <cmath>
#include <iostream>
#include <stdio.h>

#include <boost/bind.hpp>


namespace gazebo {

GazeboSonarPlugin::GazeboSonarPlugin()
    : node_handle_(0) {}

GazeboSonarPlugin::~GazeboSonarPlugin() {
  event::Events::DisconnectWorldUpdateBegin(updateConnection);
  if (node_handle_) {
    node_handle_->shutdown();
    delete node_handle_;
  }
}

////////////////////////////////////////////////////////////////////////////////
// Load the controller
void GazeboSonarPlugin::Load(sensors::SensorPtr _sensor, sdf::ElementPtr _sdf) {

  // Get then name of the parent sensor
#if GAZEBO_MAJOR_VERSION >= 7
  sensor_ = std::dynamic_pointer_cast<sensors::RaySensor>(_sensor);
#else
  sensor_ = boost::dynamic_pointer_cast<sensors::RaySensor>(_sensor);
#endif
  if (!sensor_)
  {
    gzthrow("GazeboSonarPlugin requires a Ray Sensor as its parent");
    return;
  }
  // Get the world name.
  std::string worldName = sensor_->GetWorldName();
  world = physics::get_world(worldName);

  // default parameters
  namespace_.clear();
  topic_ = "sonar";
  frame_id_ = "/sonar_link";

  // load parameters
  if (_sdf->HasElement("robotNamespace"))
    namespace_ = _sdf->GetElement("robotNamespace")->Get<std::string>();

  if (_sdf->HasElement("frameId"))
    frame_id_ = _sdf->GetElement("frameId")->Get<std::string>();

  if (_sdf->HasElement("topicName"))
    topic_ = _sdf->GetElement("topicName")->Get<std::string>();

  range_.header.frame_id = frame_id_;
  range_.radiation_type = sensor_msgs::Range::ULTRASOUND;
#if GAZEBO_MAJOR_VERSION >= 7
  range_.field_of_view = std::min(fabs((sensor_->AngleMax() - sensor_->AngleMin()).Radian()), fabs((sensor_->VerticalAngleMax() - sensor_->VerticalAngleMin()).Radian()));
#else
  range_.field_of_view = std::min(fabs((sensor_->GetAngleMax() - sensor_->GetAngleMin()).Radian()), fabs((sensor_->GetVerticalAngleMax() - sensor_->GetVerticalAngleMin()).Radian()));
#endif
  range_.max_range = sensor_->GetRangeMax();
  range_.min_range = sensor_->GetRangeMin();

  // Make sure the ROS node for Gazebo has already been initialized
  if (!ros::isInitialized())
  {
    ROS_FATAL_STREAM("A ROS node for Gazebo has not been initialized, unable to load plugin. "
      << "Load the Gazebo system plugin 'libgazebo_ros_api_plugin.so' in the gazebo_ros package)");
    return;
  }

  node_handle_ = new ros::NodeHandle(namespace_);
  publisher_ = node_handle_->advertise<sensor_msgs::Range>(topic_, 1);


  // Listen to the update event. This event is broadcast every
  // simulation iteration.
  this->updateConnection =
      event::Events::ConnectWorldUpdateBegin(
          boost::bind(&GazeboSonarPlugin::OnUpdate, this, _1));

  // activate RaySensor
  sensor_->SetActive(true);
}



////////////////////////////////////////////////////////////////////////////////
// Update the controller
void GazeboSonarPlugin::OnUpdate(const common::UpdateInfo& _info) 
{
  common::Time current_time  = world->GetSimTime();
  double dt = (current_time - last_time_).Double();
  last_time_ = current_time;

  // activate RaySensor if it is not yet active
  if (!sensor_->IsActive()) sensor_->SetActive(true);

  range_.header.stamp.sec  = (world->GetSimTime()).sec;
  range_.header.stamp.nsec = (world->GetSimTime()).nsec;

  // find ray with minimal range
  range_.range = std::numeric_limits<sensor_msgs::Range::_range_type>::max();
  int num_ranges = sensor_->GetLaserShape()->GetSampleCount() * sensor_->GetLaserShape()->GetVerticalSampleCount();
  for(int i = 0; i < num_ranges; ++i) {
    double ray = sensor_->GetLaserShape()->GetRange(i);
    if (ray < range_.range) range_.range = ray;
  }

  // add Gaussian noise (and limit to min/max range)
  if (range_.range < range_.max_range) {
    range_.range += 0.0; //TODO
    if (range_.range < range_.min_range) range_.range = range_.min_range;
    if (range_.range > range_.max_range) range_.range = range_.max_range;
  }

  publisher_.publish(range_);
}

// Register this plugin with the simulator
GZ_REGISTER_SENSOR_PLUGIN(GazeboSonarPlugin)

} // namespace gazebo
