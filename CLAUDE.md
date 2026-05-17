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
| `v2.0` | Branch `v2.0` do `drone_inspetor` |

## Mensagens (msg/)

| Mensagem | Descrição | Campos principais |
|---|---|---|
| `DroneStateMSG` | Telemetria completa do drone | state, posição local/global (NED + GPS), yaw (3 formatos), velocidade, aceleração, is_armed, is_landed, trajetória ajustada, ponto de foco |
| `MissionStateMSG` | Estado da máquina de estados de missão | state, on_mission, mission_name, waypoint atual/total, objeto alvo, tipos de anomalia |
| `CVDetectionMSG` | Resultado agregado de detecção CV | timestamp, count, array de CVDetectionItemMSG |
| `CVDetectionItemMSG` | Detecção individual de objeto | object_type, class_name, confidence, bbox [x1,y1,x2,y2], bbox_center |
| `CVControlMSG` | Comando de seleção de modelo CV | object_detection_model, anomaly_detection_model |
| `DashboardMissionCommandMSG` | Comando do dashboard para mission_node | command (int32), mission (string) |
| `MissionCommandMSG` | Coordenação de ciclo de missão | command (1=START, 2=STOP), data |
| `LidarMSG` | Dados raw do LiDAR | point_vector [dist,angle,...], ground_distance |
| `ObstaclesMSG` | Obstáculos detectados — genérico, publicado por `lidar_node` e `depth_node`; `drone_node` mescla as fontes via OR. Sensores deixam em `false` campos que não conseguem inferir. | flags booleanos: por distância (8m,5m,3m,2m,1m), por quadrante de 90° (front,right,back,left), abaixo (1m,0.5m) |

## Serviços (srv/)

| Serviço | Request → Response |
|---|---|
| `CVDetectionSRV` | `object_name, anomaly_types[], timeout` → `success, confidence, bbox, bbox_center` |
| `RecordDetectionsSRV` | `start_recording (bool)` → `success, message, video_path` |
| `EnableAnomalyDetectionSRV` | `enable (bool)` → `success, message` |
| `CVModelsSRV` | `(vazio)` → `models_data_json, current_object_model, current_anomaly_model` |

## Action (action/)

**DroneCommand** — enviada pelo Mission Node ao Drone Node:
- **Goal:** `command` (ARM/DISARM/TAKEOFF/GOTO/LAND/RTL/STOP), `lat/lon/alt/yaw`, `use_focus` (bool), `focus_lat/focus_lon`, `altitude`. Com `use_focus=true`, GOTO mantém yaw apontando para o ponto de foco ao longo de toda a trajetória (campo `yaw` é ignorado).
- **Result:** `success, message, final_state`
- **Feedback:** `current_state, state_name, distance_to_target, progress_percent`
