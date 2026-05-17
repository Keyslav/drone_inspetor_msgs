cmake_minimum_required(VERSION 3.8)
project(drone_inspetor_msgs)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# find dependencies
find_package(ament_cmake REQUIRED)
find_package(rosidl_default_generators REQUIRED)
find_package(std_msgs REQUIRED)
find_package(action_msgs REQUIRED)

rosidl_generate_interfaces(${PROJECT_NAME}
  "msg/DroneStateMSG.msg"
  "msg/MissionStateMSG.msg"
  "msg/CVDetectionItemMSG.msg"
  "msg/CVDetectionMSG.msg"
  "msg/DashboardMissionCommandMSG.msg"
  "msg/LidarMSG.msg"
  "msg/ObstaclesMSG.msg"
  "msg/MissionCommandMSG.msg"
  "msg/CVControlMSG.msg"
  "action/DroneCommand.action"
  "srv/CVDetectionSRV.srv"
  "srv/RecordDetectionsSRV.srv"
  "srv/EnableAnomalyDetectionSRV.srv"
  "srv/CVModelsSRV.srv"
  DEPENDENCIES std_msgs action_msgs
)

ament_export_dependencies(rosidl_default_runtime)

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()
endif()

ament_package()

