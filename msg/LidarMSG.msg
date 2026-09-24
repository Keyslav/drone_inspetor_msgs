# =============================================================================
# Mensagem de Dados do LiDAR (LidarMSG)
# Publicada pelo lidar_node para o dashboard_lidar_subscriber
# =============================================================================

# --- Vetor de Pontos do LiDAR 2D ---
# Formato: [distancia1, angulo1, distancia2, angulo2, ...]
# Distâncias em metros, ângulos em radianos no referencial do LaserScan (ROS/FLU):
# zero à frente, +pi/2 à esquerda, -pi/2 à direita; não são rumos NED do PX4.
# Somente retornos válidos são incluídos. Vetor vazio não comprova espaço livre.
float32[] point_vector

# --- Sensor de Distância Inferior (Altímetro LiDAR) ---
float32 ground_distance          # Distância abaixo (metros); NaN se desconhecida/expirada
