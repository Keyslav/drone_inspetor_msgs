# =============================================================================
# Mensagem de Status do Drone (DroneStateMSG)
# Publicada pelo drone_node para informar o estado atual do drone
# =============================================================================

# --- Estado e Flags ---
int16 state                            # Código do estado atual (DroneStateDescription)
string state_name                      # Nome do estado atual (ex: "VOANDO_PRONTO")
float64 state_duration_sec             # Tempo em segundos desde que entrou no estado atual
bool is_armed                          # True se os motores estão armados
bool is_landed                         # True se o drone está pousado
bool is_on_trajectory                  # True se está executando uma trajetória

# --- Posição Corrente Local (NED) ---
float64 current_local_x                # Posição X local (metros, Norte)
float64 current_local_y                # Posição Y local (metros, Leste)
float64 current_local_z                # Posição Z local (metros, altitude positiva para cima)

# --- Posição Corrente Global (GPS) ---
float64 current_latitude               # Latitude atual (graus)
float64 current_longitude              # Longitude atual (graus)
float64 current_altitude               # Altitude atual (metros)

# --- Orientação Corrente ---
float64 current_yaw_deg                # Yaw atual (graus, 0 a 360)
float64 current_yaw_deg_normalized     # Yaw atual (graus, -180 a 180)
float64 current_yaw_rad                # Yaw atual (radianos, -pi a pi)

# --- Posição HOME Global (GPS) ---
float64 home_global_lat                # Latitude do HOME (graus)
float64 home_global_lon                # Longitude do HOME (graus)
float64 home_global_alt                # Altitude do HOME (metros)

# --- Posição HOME Local (NED) ---
float64 home_local_x                   # Posição X local do HOME (metros)
float64 home_local_y                   # Posição Y local do HOME (metros)
float64 home_local_z                   # Posição Z local do HOME (metros)

# --- Orientação HOME ---
float64 home_yaw_deg                   # Yaw do HOME (graus, 0 a 360)
float64 home_yaw_deg_normalized        # Yaw do HOME (graus, -180 a 180)
float64 home_yaw_rad                   # Yaw do HOME (radianos, -pi a pi)

# --- Posição Alvo Local (NED) ---
float64 target_local_x                 # Posição X alvo (metros)
float64 target_local_y                 # Posição Y alvo (metros)
float64 target_local_z                 # Posição Z alvo (metros)

# --- Posição Alvo Global (GPS) ---
float64 target_lat                     # Latitude alvo (graus)
float64 target_lon                     # Longitude alvo (graus)
float64 target_alt                     # Altitude alvo (metros)

# --- Orientação Alvo ---
float64 target_direction_yaw_deg       # Yaw de direção do movimento (graus, 0 a 360)
float64 target_direction_yaw_deg_normalized  # Yaw de direção do movimento (graus, -180 a 180)
float64 target_direction_yaw_rad       # Yaw de direção do movimento (radianos)
float64 target_final_yaw_deg           # Yaw final desejado no destino (graus, 0 a 360)
float64 target_final_yaw_deg_normalized # Yaw final desejado no destino (graus, -180 a 180)
float64 target_final_yaw_rad           # Yaw final desejado no destino (radianos)

# --- Ponto de Foco (para GOTO com use_focus=true) ---
float64 focus_lat                      # Latitude do ponto de foco (graus)
float64 focus_lon                      # Longitude do ponto de foco (graus)
float64 focus_yaw_deg                  # Yaw para apontar ao foco (graus, 0 a 360)
float64 focus_yaw_deg_normalized       # Yaw para apontar ao foco (graus, -180 a 180)
float64 focus_yaw_rad                  # Yaw para apontar ao foco (radianos)

# --- Última Posição Estática (para hover estável) ---
float64 last_static_position_x         # Última posição X estática (metros)
float64 last_static_position_y         # Última posição Y estática (metros)
float64 last_static_position_z         # Última posição Z estática (metros)
float64 last_static_yaw_deg            # Último yaw estático (graus, 0 a 360)
float64 last_static_yaw_deg_normalized # Último yaw estático (graus, -180 a 180)
float64 last_static_yaw_rad            # Último yaw estático (radianos)

# --- Ponto de Desvio de Trajetória (quando há obstáculos) ---
bool has_trajectory_adjusted           # True se há um ponto de desvio ativo
float64 trajectory_adjusted_x          # Posição X do ponto de desvio (metros)
float64 trajectory_adjusted_y          # Posição Y do ponto de desvio (metros)
float64 trajectory_adjusted_z          # Posição Z do ponto de desvio (metros)

# --- Velocidade Corrente (m/s) ---
float64 current_velocity_x             # Velocidade X local (m/s, Norte)
float64 current_velocity_y             # Velocidade Y local (m/s, Leste)
float64 current_velocity_z             # Velocidade Z local (m/s, para baixo)

# --- Aceleração Corrente (m/s²) ---
float64 current_acceleration_x         # Aceleração X local (m/s²)
float64 current_acceleration_y         # Aceleração Y local (m/s²)
float64 current_acceleration_z         # Aceleração Z local (m/s²)


