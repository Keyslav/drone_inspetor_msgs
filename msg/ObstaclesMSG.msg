# =============================================================================
# Mensagem de Detecção de Obstáculos (ObstaclesMSG)
# Resumo legado para apresentação, publicado por lidar_node e depth_node.
# A cobertura depende do sensor configurado; não pressupõe LiDAR de 360°.
# False significa ausência de detecção e também pode representar dado desconhecido.
# Na v2, drone_node usa os LaserScan métricos originais, pose e idade das amostras;
# estas flags não autorizam movimento nem comprovam que um corredor está livre.
# =============================================================================

# --- Obstáculos por Distância (qualquer direção horizontal coberta pelo sensor) ---
bool have_obstacles_8m              # Obstáculo em raio de 8 metros
bool have_obstacles_5m              # Obstáculo em raio de 5 metros
bool have_obstacles_3m              # Obstáculo em raio de 3 metros
bool have_obstacles_2m              # Obstáculo em raio de 2 metros
bool have_obstacles_1m              # Obstáculo em raio de 1 metro

# --- Obstáculos por Quadrante (1 metro, arcos FLU/ROS; positivo à esquerda) ---
# Limite inicial inclusivo e final exclusivo, sem duplicar pontos nas fronteiras.
bool have_obstacles_front_90        # Frente: [-45°, +45°)
bool have_obstacles_right_90        # Direita: [-135°, -45°)
bool have_obstacles_back_90         # Trás: [+135°, +180°] e [-180°, -135°)
bool have_obstacles_left_90         # Esquerda: [+45°, +135°)

# --- Sensor Inferior (lidar_down) ---
bool have_obstacles_down_1m         # Obstáculo a até 1 metro abaixo
bool have_obstacles_down_05m        # Obstáculo a até 0.5 metro abaixo
