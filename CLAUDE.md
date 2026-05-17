# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

# drone_inspetor_msgs

Pacote ROS2 (ament_cmake) de interfaces customizadas (mensagens, serviços e actions) para o sistema drone_inspetor de inspeção industrial autônoma com drone. Deve ser compilado **antes** do pacote `drone_inspetor`, pois é dependência dele.

## Build e verificação

```bash
# Compilar
cd ~/ros2_ws
colcon build --packages-select drone_inspetor_msgs
source install/setup.bash

# Verificar uma interface gerada
ros2 interface show drone_inspetor_msgs/msg/DroneStateMSG
ros2 interface show drone_inspetor_msgs/action/DroneCommand
ros2 interface show drone_inspetor_msgs/srv/CVDetectionSRV
```

## Adicionando uma nova interface

1. Criar o arquivo em `msg/`, `srv/` ou `action/` seguindo o padrão de nomenclatura existente (`NomeMSG.msg`, `NomeSRV.srv`, `NomeAction.action`)
2. Registrar o novo arquivo em `CMakeLists.txt` dentro do bloco `rosidl_generate_interfaces()`
3. Se usar tipos de outros pacotes além de `std_msgs`/`action_msgs`, adicioná-los em `DEPENDENCIES` no mesmo bloco e como `<depend>` no `package.xml`

## Branches

| Branch | Corresponde a |
|---|---|
| `v1.0` | Branch `v1.0` do `drone_inspetor` |

## Mensagens (msg/)

| Mensagem | Descrição | Campos principais |
|---|---|---|
| `DroneStateMSG` | Telemetria completa do drone | state, posição local/global (NED + GPS), yaw (3 formatos), velocidade, aceleração, is_armed, is_landed, trajetória ajustada, ponto de foco (para GOTO_FOCUS) |
| `FSMStateMSG` | Estado da máquina de estados (`fsm_node`) | state, on_mission, cancel_mission, mission_name, mission_folder_path, takeoff_altitude, waypoint atual/total, tempo_de_permanencia, objeto_alvo, tipos_anomalia |
| `CVDetectionMSG` | Resultado agregado de detecção CV | timestamp, count, array de CVDetectionItemMSG |
| `CVDetectionItemMSG` | Detecção individual de objeto | object_type, class_name, confidence, bbox [x1,y1,x2,y2], bbox_center |
| `CVControlMSG` | Comando de seleção de modelo CV | object_detection_model, anomaly_detection_model |
| `DashboardFsmCommandMSG` | Comando do dashboard para `fsm_node` | command (int32, enum DashboardFsmCommandDescription), mission (string) |
| `MissionCommandMSG` | Coordenação de ciclo de missão | command (1=START, 2=STOP), data |
| `LidarMSG` | Dados raw do LiDAR | point_vector [dist,angle,...], ground_distance |
| `LidarObstaclesMSG` | Obstáculos detectados pelo `lidar_node` (consumida diretamente pelo `drone_node`) | flags booleanos: por distância (8m,5m,3m,2m,1m), por quadrante de 90° (front,right,back,left), abaixo (1m,0.5m) |

## Serviços (srv/)

| Serviço | Request → Response |
|---|---|
| `CVDetectionSRV` | `object_name, anomaly_types[], timeout` → `success, confidence, bbox, bbox_center` |
| `RecordDetectionsSRV` | `start_recording (bool)` → `success, message, video_path` |
| `EnableAnomalyDetectionSRV` | `enable (bool)` → `success, message` |
| `CVModelsSRV` | `(vazio)` → `models_data_json, current_object_model, current_anomaly_model` |

## Action (action/)

**DroneCommand** — enviada pelo FSM Node ao Drone Node:
- **Goal:** `command` (ARM/DISARM/TAKEOFF/GOTO/**GOTO_FOCUS**/LAND/RTL/STOP), `lat/lon/alt/yaw`, `focus_lat/focus_lon` (exclusivo de GOTO_FOCUS), `altitude` (TAKEOFF). Em v1.0, GOTO_FOCUS é um comando separado de GOTO — passa `focus_lat/focus_lon` e o drone mantém o yaw apontando para esse ponto durante toda a trajetória.
- **Result:** `success, message, final_state`
- **Feedback:** `current_state, state_name, distance_to_target, progress_percent`
