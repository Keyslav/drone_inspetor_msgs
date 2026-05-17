# =============================================================================
# Mensagem de Detecção de Obstáculos (ObstaclesMSG)
# Mensagem genérica para detecção de obstáculos. Publicada por sensores como
# lidar_node (cobertura 360° + abaixo) e depth_node (cobertura frontal),
# consumida pelo drone_node que mescla as fontes (OR) para evitar colisões.
# Sensores devem deixar em False os campos que não conseguem inferir.
# =============================================================================

# --- Obstáculos por Distância (qualquer direção horizontal coberta pelo sensor) ---
bool have_obstacles_8m              # Obstáculo em raio de 8 metros
bool have_obstacles_5m              # Obstáculo em raio de 5 metros
bool have_obstacles_3m              # Obstáculo em raio de 3 metros
bool have_obstacles_2m              # Obstáculo em raio de 2 metros
bool have_obstacles_1m              # Obstáculo em raio de 1 metro

# --- Obstáculos por Quadrante (1 metro, arcos de 90°) ---
bool have_obstacles_front_90        # Frente: -45° a +45°
bool have_obstacles_right_90        # Direita: +45° a +135°
bool have_obstacles_back_90         # Trás: +135° a -135° (ou ±180°)
bool have_obstacles_left_90         # Esquerda: -45° a -135°

# --- Sensor Inferior (lidar_down) ---
bool have_obstacles_down_1m         # Obstáculo a até 1 metro abaixo
bool have_obstacles_down_05m        # Obstáculo a até 0.5 metro abaixo
