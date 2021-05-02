#include "ros/ros.h"
#include "data_gather.h"


int main(int argc, char **argv)
{
  ros::init(argc, argv, "Capstone_ROS");

  ros::NodeHandle nh;

  std::shared_ptr<Data_Gather> gc(new Data_Gather(nh));

  std::thread Operator_Thread(&Data_Gather::Operator_Thread,gc);
  std::thread IO_Thread(&Data_Gather::IO_Thread,gc);

  ros::spin();

  ros::shutdown();
  Operator_Thread.join();
  IO_Thread.join();

  return 0;

}
