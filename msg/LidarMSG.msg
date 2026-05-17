# =============================================================================
# Mensagem de Dados do LiDAR (LidarMSG)
# Publicada pelo lidar_node para o dashboard_lidar_subscriber
# =============================================================================

# --- Vetor de Pontos do LiDAR 2D ---
# Formato: [distancia1, angulo1, distancia2, angulo2, ...]
# Distâncias em metros, ângulos em radianos
float32[] point_vector

# --- Sensor de Distância Inferior (Altímetro LiDAR) ---
float32 ground_distance          # Distância até o solo/obstáculo abaixo (metros)
