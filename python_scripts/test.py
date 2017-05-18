#!/usr/bin/env python
import os
import argparse
import json
import zmq
import rospy
import time
import subprocess
import socket

import std_msgs.msg

from add_sensor_functions import add_lidar
from add_sensor_functions import copy_base_rover_file


# Get host name
str_host_name = socket.gethostname()

print(str_host_name)

str_rover_file = copy_base_rover_file(str_host_name)

