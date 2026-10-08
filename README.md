# drone_inspetor_msgs — v2.0

Este README explica como compilar e conferir os contratos ROS 2 usados pelo
`drone_inspetor`: mensagens, serviços e a action `DroneCommand`. Este pacote usa
`ament_cmake`/rosidl para gerar as interfaces; não contém nós executáveis nem
arquivos de launch. A aplicação que usa esses contratos é `ament_python`.

| Documento | Para que serve |
|---|---|
| Este README | Compilação das interfaces, compatibilidade e referência dos contratos |
| [CLAUDE.md](CLAUDE.md) | Orientações para assistentes e contribuidores alterarem os contratos |
| [README da aplicação](../drone_inspetor/README.md) | Preparação do workspace, dependências e build completo |
| [Guia de execução](../drone_inspetor/docs/EXECUCAO.md) | Escolha de perfil, iniciadores e comandos para executar a aplicação |
| [INIT_SIMULACAO.md](../drone_inspetor/INIT_SIMULACAO.md) | Montagem do ambiente local de Gazebo, PX4 SITL e comunicação DDS |

## Compilar e verificar as interfaces

A base do projeto é Ubuntu 24.04 e ROS 2 Jazzy. Com ROS Jazzy, `colcon` e `rosdep`
instalados e este repositório em `~/ros2_ws/src/drone_inspetor_msgs`:

```bash
source /opt/ros/jazzy/setup.bash
cd ~/ros2_ws
# Na primeira instalação do rosdep: sudo rosdep init
rosdep update
rosdep install --from-paths src/drone_inspetor_msgs \
  --ignore-src --rosdistro jazzy -r -y
colcon build --packages-select drone_inspetor_msgs
source install/setup.bash
ros2 interface show drone_inspetor_msgs/action/DroneCommand
ros2 interface show drone_inspetor_msgs/msg/DashboardMissionCommandMSG
ros2 interface show drone_inspetor_msgs/msg/MissionStateMSG
python3 -c 'from drone_inspetor_msgs.action import DroneCommand; from drone_inspetor_msgs.msg import DashboardMissionCommandMSG, MissionStateMSG'
```

Esse build gera somente as interfaces. PX4, Gazebo, Qt e pesos de visão
computacional não são necessários para isso. Para compilar e executar a aplicação
com suas dependências, siga o [README da aplicação](../drone_inspetor/README.md).

## Compatibilidade com a aplicação v2

`drone_inspetor_msgs` e `drone_inspetor` declaram versão `2.0.0` em `package.xml`
e devem usar a mesma linha `v2.0`. A v2 usa
`DashboardMissionCommandMSG`, `MissionStateMSG` e `GOTO` com `use_focus`; ela não é
compatível com as mensagens e nomes de comandos anteriores.

Trocar somente a branch não atualiza os módulos gerados em `install`, mesmo com
`--symlink-install`. Em um workspace já preparado, recompile os dois pacotes com
o mesmo Python usado na execução e carregue o overlay atualizado:

```bash
source /opt/ros/jazzy/setup.bash
cd ~/ros2_ws
# Ative o ambiente Python da aplicação, se estiver usando um venv.
python -m colcon build --symlink-install \
  --packages-select drone_inspetor_msgs drone_inspetor
source install/setup.bash
python -c 'from drone_inspetor_msgs.msg import DashboardMissionCommandMSG, MissionStateMSG; from drone_inspetor_msgs.action import DroneCommand'
```

Ao migrar da v1 ou comparar branches, use um terminal novo e um build/install
isolado, conforme o [README da aplicação](../drone_inspetor/README.md).
Reinicie os consumidores após recompilar. Um build em outro diretório só é usado
quando seu próprio `install/setup.bash` é carregado; ele não atualiza o overlay
normal do workspace.

## Contratos disponíveis

| Interfaces | Finalidade |
|---|---|
| `DroneStateMSG`, `MissionStateMSG` | Telemetria do drone e estado da missão |
| `DashboardMissionCommandMSG`, `MissionCommandMSG` | Comandos do dashboard para a missão e coordenação de início/fim de sessão |
| `CVControlMSG`, `CVDetectionMSG`, `CVDetectionItemMSG` | Seleção de modelos e resultados de detecção |
| `LidarMSG`, `ObstaclesMSG` | Dados resumidos do LiDAR e detecções de obstáculos para apresentação |
| `CVDetectionSRV`, `CVModelsSRV` | Solicitação de detecção e consulta do catálogo de modelos |
| `RecordDetectionsSRV`, `EnableAnomalyDetectionSRV` | Controle de gravação e detecção de anomalias |
| `DroneCommand` | Comandos de voo com resultado e feedback: `ARM`, `DISARM`, `TAKEOFF`, `GOTO`, `LAND`, `RTL` e `STOP` |

As definições ficam em [msg/](msg/), [srv/](srv/) e
[action/](action/); a lista compilada está em [CMakeLists.txt](CMakeLists.txt).
O campo `DroneCommand.alt` usa altitude absoluta AMSL; `altitude` é a altura de
decolagem acima do HOME. O yaw público usa graus no referencial NED.
`DroneStateMSG` preserva posições locais NEU legadas, enquanto velocidades e
acelerações usam NED. Consulte o
[contrato de coordenadas](../drone_inspetor/docs/COORDENADAS.md) para integrar
novos consumidores.

## Alterações e validação

Os comentários em `msg/`, `srv/` e `action/` são a definição do contrato. Para novas
mudanças, preserve nome, significado e unidades dos campos quando possível; teste os
consumidores usando as classes ROS geradas. Serviços usam nomes como `object_name`,
`anomaly_types` e `timeout_seconds`, independentemente do idioma dos estados internos.

A suíte da aplicação contém testes de requests/respostas reais e converte detecções
em snapshots imutáveis para a GUI. A CI da aplicação compila este repositório antes
de executar esses testes. Os comandos de validação ficam no
[README da aplicação](../drone_inspetor/README.md).
