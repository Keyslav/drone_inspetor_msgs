# drone_inspetor_msgs

Pacote ROS2 (ament_cmake) de interfaces customizadas (mensagens, serviços e actions) para o sistema drone_inspetor de inspeção industrial autônoma com drone.

## Mensagens (msg/)

| Mensagem | Descrição | Campos principais |
|---|---|---|
| `DroneStateMSG` | Telemetria completa do drone | state, posição local/global, yaw, velocidade, aceleração, is_armed, is_landed, trajetória ajustada |
| `MissionStateMSG` | Estado da máquina de estados de missão | state, on_mission, mission_name, waypoint atual/total, objeto alvo, tipos de anomalia |
| `CVDetectionMSG` | Resultado agregado de detecção CV | timestamp, count, array de CVDetectionItemMSG |
| `CVDetectionItemMSG` | Detecção individual de objeto | object_type, class_name, confidence, bbox [x1,y1,x2,y2], bbox_center |
| `CVControlMSG` | Comando de seleção de modelo CV | object_detection_model, anomaly_detection_model |
| `DashboardMissionCommandMSG` | Comando do dashboard para mission_node | command (int32), mission (string) |
| `MissionCommandMSG` | Coordenação de ciclo de missão | command (1=START, 2=STOP), data |
| `LidarMSG` | Dados raw do LiDAR | point_vector [dist,angle,...], ground_distance |
| `ObstaclesMSG` | Obstáculos detectados (genérico, usado por lidar_node e depth_node) | flags booleanos: por distância (8m,5m,3m,2m,1m), por quadrante (front,right,back,left), para baixo (1m,0.5m) |

## Serviços (srv/)

| Serviço | Descrição | Request → Response |
|---|---|---|
| `CVDetectionSRV` | Detecção sob demanda de objeto + anomalias | object_name, anomaly_types[], timeout → success, confidence, bbox, bbox_center |
| `RecordDetectionsSRV` | Controle de gravação de vídeo CV | start_recording (bool) → success, message, video_path |
| `EnableAnomalyDetectionSRV` | Liga/desliga rede de anomalias | enable (bool) → success, message |
| `CVModelsSRV` | Lista modelos CV disponíveis | (vazio) → models_data_json, current_object_model, current_anomaly_model |

## Actions (action/)

| Action | Descrição |
|---|---|
| `DroneCommand` | Comando de movimentação do drone (Mission Node→Drone) |

**DroneCommand detalhes:**
- **Goal:** command (ARM/DISARM/TAKEOFF/GOTO/LAND/RTL/STOP), lat/lon/alt/yaw, use_focus (bool), focus_lat/focus_lon, altitude. Quando `use_focus=true`, o GOTO mantém o yaw apontando para focus_lat/focus_lon ao longo do trajeto (ignora `yaw`).
- **Result:** success, message, final_state
- **Feedback:** current_state, state_name, distance_to_target, progress_percent

## Dependências

- `rosidl_default_generators` / `rosidl_default_runtime` (geração de interfaces)
- `std_msgs` (tipos base)
- `action_msgs` (suporte a actions)

## Build

```bash
cd ~/ros2_ws
colcon build --packages-select drone_inspetor_msgs
source install/setup.bash
```

Deve ser compilado antes de `drone_inspetor`, pois é dependência dele.
