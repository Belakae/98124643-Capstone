#include "data_gather.h"


Data_Gather::Data_Gather(ros::NodeHandle nh)
  : nh_(nh)
{
  sub1_ = nh_.subscribe("/joint_states",1000, &Data_Gather::JointStateCallback,this);
  sub2_ = nh_.subscribe("/wrench",1000, &Data_Gather::WrenchCallback,this);
  sub3_ = nh_.subscribe("/ur_hardware_interface/io_states",1000, &Data_Gather::IOStateCallback,this);


  zero.open("zero.txt",std::ios::out | std::ios::trunc);
  visc.open("visc.txt",std::ios::out | std::ios::trunc);

}

Data_Gather::~Data_Gather()
{
  zero.close();

  com.close();

  visc.close();
}

void Data_Gather::JointStateCallback(const sensor_msgs::JointStateConstPtr& msg)
{
  std::unique_lock<std::mutex> lck (jointstateDataBuffer_.mtx);
  jointstateDataBuffer_.JointState = *msg;
}

void Data_Gather::WrenchCallback(const geometry_msgs::WrenchStampedConstPtr& msg)
{
  std::unique_lock<std::mutex> lck (wrenchDataBuffer_.mtx);
  wrenchDataBuffer_.Wrench = *msg;
}

void Data_Gather::IOStateCallback(const ur_msgs::IOStatesConstPtr &msg)
{
  std::unique_lock<std::mutex> lck (iostateDataBuffer_.mtx);
  iostateDataBuffer_.IOStates_ = *msg;
}

void Data_Gather::IO_Thread()
{
  while(ros::ok())
  {
    if(iostateDataBuffer_.IOStates_.digital_out_states.size() != 0)
    {
      iostates_.program_start_ = iostateDataBuffer_.IOStates_.digital_out_states.at(0);
      iostates_.com_reading_ = iostateDataBuffer_.IOStates_.digital_out_states.at(1);
      iostates_.continuous_readings_ = iostateDataBuffer_.IOStates_.digital_out_states.at(2);
      iostates_.zero_fts_ = iostateDataBuffer_.IOStates_.digital_out_states.at(3);
      iostates_.save_data_ = iostateDataBuffer_.IOStates_.digital_out_states.at(4);
    }
  }
}

void Data_Gather::Operator_Thread()
{
    ros::Rate rate_limiter(1);

    vector<double> CoM_data_readings;
    vector<double> Visc_data_readings;

    vector<double> zero_force;
    vector<double> zero_torque;

    while(ros::ok())
    {

      if(iostates_.zero_fts_.state == 1)
      {
        zero_force.push_back(wrenchDataBuffer_.Wrench.wrench.force.y);
        zero_torque.push_back(wrenchDataBuffer_.Wrench.wrench.torque.z);

        ROS_INFO_STREAM("Collecting Zero Data");
      }

      while(iostates_.program_start_.state == 1)
      {

        //calculate the mean zero from the data gathered before

        if(zero_force.size() != 0)
        {
          //zerodata_.y = (accumulate(zero_force.begin(),zero_force.end(),0.0))/(zero_force.size());
          //zerodata_.t_z = (accumulate(zero_torque.begin(),zero_torque.end(),0.0))/(zero_torque.size());

          zerodata_.data_ = zero_torque;

          ROS_INFO_STREAM(zero_torque.size());

          zero_force.clear();
          zero_torque.clear();

        }

        if(iostates_.com_reading_.state == 1)
        {
          ROS_INFO_STREAM("Collecting Data");

          double torque_z = wrenchDataBuffer_.Wrench.wrench.torque.z;

          CoM_data_readings.push_back(torque_z);
        }
        else if(CoM_data_readings.size() != 0)
        {

          comdata_.data_ = CoM_data_readings;
          comdata_.angle_ = jointstateDataBuffer_.JointState.position.at(5) * 180.0/M_PI;

          matlabdata_.single_readings_.push_back(comdata_);


          CoM_data_readings.clear();    //removes all data from the vector and resets its size to 0


          ROS_INFO_STREAM("CoM Reading Recorded");


        }

        if(iostates_.continuous_readings_.state == 1)
        {
          ROS_INFO_STREAM("Collecting Dynamic Data");

          double torque_data = wrenchDataBuffer_.Wrench.wrench.torque.z;

          Visc_data_readings.push_back(torque_data);

          matlabdata_.many_readings_ = Visc_data_readings;

        }

        if(iostates_.save_data_.state == 1)
        {
          Data_Gather::Send_Data();
        }
      }
    }

}

void Data_Gather::Send_Data()
{
  ROS_INFO_STREAM("");
  ROS_INFO_STREAM("Writing Data Files");
  ROS_INFO_STREAM("");


  // Write data for the sensor zero readings

  if(zero.is_open())
  {
    vector<double> zero_data = zerodata_.data_;
    int size = zero_data.size();

    // <vector size> <vector data>

    //zero << "<vector size> <zero data>" << std::endl;

    zero << size << ",";

    /*
    for(double value : zero_data)
    {
      zero << value << ",";
    }
    zero << std::endl;
    */

    for(int i=0;i<zero_data.size();i++)
    {
      zero << zero_data.at(i);

      if(i != zero_data.size()-1)
      {
        zero << ",";
      }
    }
    zero << std::endl;

    ROS_INFO_STREAM("File Written: zero.txt");

    zero.close();
  }

  // Write data for the centre of mass readings

  for(int i = 0; i < matlabdata_.single_readings_.size(); i++)
  {

    const std::string iterator = std::to_string(i+1);
    const std::string filename = "CoM_" + iterator + ".txt";

    com.open(filename,std::ios::out | std::ios::trunc);

    CoM_data next_data = matlabdata_.single_readings_.at(i);

    // <angle> <vector size> <com data>

    //com << "<angle> <vector size> <com data>" << std::endl;

    com << next_data.angle_ << ",";

    com << next_data.data_.size() << ",";

    /*
    for(double value : next_data.data_)
    {
      com << value << " ";
    }
    com << std::endl;
    */

    for(int i=0;i<next_data.data_.size();i++)
    {
      com << next_data.data_.at(i);

      if(i != next_data.data_.size()-1)
      {
        com << ",";
      }
    }
    com << std::endl;

    ROS_INFO_STREAM("File Written: " + filename);

    com.close();

  }


  // Write data for the dynamic torque readings

  if(visc.is_open())
  {
    vector<double> many_readings = matlabdata_.many_readings_;
    int many_size = many_readings.size();

    // Writing file header <vector size> <vector data>

    //visc << "<vector size> <vector data>" << std::endl;

    // Writing data to file

    visc << many_size << ",";

    /*
    for(double value : many_readings)
    {
      visc << value << " ";
    }
    visc << endl;
    */

    for(int i=0;i<many_readings.size();i++)
    {
      visc << many_readings.at(i);

      if(i != many_readings.size()-1)
      {
        visc << ",";
      }
    }
    visc << std::endl;

    ROS_INFO_STREAM("File Written: visc.txt");

    visc.close();
  }
}
