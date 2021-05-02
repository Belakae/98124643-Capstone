#ifndef DATA_GATHER_H
#define DATA_GATHER_H

#include <sstream>
#include <iostream>
#include <iterator>
#include <fstream>
#include <string>
#include <vector>
#include <thread>
#include <mutex>
#include <atomic>
#include <chrono>
#include <numeric>

#include "ros/ros.h"
#include "ros/service.h"
#include "ros/service_client.h"
#include "std_srvs/SetBool.h"
#include "std_msgs/String.h"
#include "std_msgs/Bool.h"
#include "std_msgs/Float64.h"
#include "std_msgs/Float64MultiArray.h"
#include "sensor_msgs/JointState.h"
#include "geometry_msgs/WrenchStamped.h"
#include "ur_msgs/Digital.h"
#include "ur_msgs/IOStates.h"


using namespace std;


class Data_Gather
{

public:

  Data_Gather(ros::NodeHandle nh);

  ~Data_Gather();

  void JointStateCallback(const sensor_msgs::JointStateConstPtr& msg);

  void WrenchCallback(const geometry_msgs::WrenchStampedConstPtr& msg);

  void IOStateCallback(const ur_msgs::IOStatesConstPtr& msg);

  void Operator_Thread();

  void IO_Thread();

  void Send_Data();

private:

  ros::NodeHandle nh_; //! ROS node handle
  ros::Subscriber sub1_;  //! Subscriber 1
  ros::Subscriber sub2_;  //! Subscriber 2
  ros::Subscriber sub3_;  //! Subscriber 3

  ofstream zero;

  ofstream com;

  ofstream visc;


  struct JointStateDataBuffer
  {
    sensor_msgs::JointState JointState;
    std::mutex mtx;
  };
  JointStateDataBuffer jointstateDataBuffer_;

  struct WrenchDataBuffer
  {
    geometry_msgs::WrenchStamped Wrench;
    std::mutex mtx;
  };
  WrenchDataBuffer wrenchDataBuffer_;

  struct IOStateDataBuffer
  {
    ur_msgs::IOStates IOStates_;
    std::mutex mtx;
  };
  IOStateDataBuffer iostateDataBuffer_;

  struct IOStates
  {
    ur_msgs::Digital program_start_;        //0
    ur_msgs::Digital com_reading_;          //1
    ur_msgs::Digital continuous_readings_;  //2
    ur_msgs::Digital zero_fts_;             //3
    ur_msgs::Digital save_data_;            //4
  };
  IOStates iostates_;

  struct ZeroData
  {
    //double y;
    //double t_z;

    vector<double> data_;

  };
  ZeroData zerodata_;

  struct CoM_data
  {
    double angle_;

    vector<double> data_;
  };
  CoM_data comdata_;

  struct MatlabData
  {
    double mass_;

    //vector<double> angle_readings_;

    //vector<double> single_readings_;

    vector<CoM_data> single_readings_;

    vector<double> many_readings_;
  };
  MatlabData matlabdata_;

};

#endif // DATA_GATHER_H
