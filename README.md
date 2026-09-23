# drone_inspetor_msgs — v2.0

Contratos ROS 2 usados pelo `drone_inspetor`: mensagens, serviços e a action
`DroneCommand`. Este pacote é `ament_cmake`/rosidl; a aplicação é `ament_python`.
Ambos declaram versão `2.0.0` e devem ser compilados a partir da linha `v2.0`.

```bash
source /opt/ros/jazzy/setup.bash
cd ~/ros2_ws
colcon build --packages-select drone_inspetor_msgs drone_inspetor
source install/setup.bash
ros2 interface show drone_inspetor_msgs/action/DroneCommand
```

Trocar somente a branch não atualiza os módulos gerados em `install`. Ao migrar da
v1 use um build/install isolado, conforme o README da aplicação. A v2 usa
`DashboardMissionCommandMSG`, `MissionStateMSG` e `GOTO` com `use_focus`; ela não é
compatível com as mensagens e nomes de comandos anteriores.

Os comentários em `msg/`, `srv/` e `action/` são a definição do contrato. Para novas
mudanças, preserve nome, significado e unidades dos campos quando possível; teste os
consumidores usando as classes ROS geradas. Serviços usam nomes como `object_name`,
`anomaly_types` e `timeout_seconds`, independentemente do idioma dos estados internos.

A suíte da aplicação contém testes de requests/respostas reais e converte detecções
em snapshots imutáveis para a GUI. A CI da aplicação compila este repositório antes
de executar esses testes. PX4 e Gazebo não são necessários para gerar as interfaces.
