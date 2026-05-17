# =============================================================================
# Mensagem de Comando de Missão (MissionCommandMSG)
# Publicada pelo FSM para coordenar início/fim de missões entre nós
# =============================================================================

# --- Tipo de Comando ---
# 1 = START_MISSION (inicia gravação, passa nome da missão em data)
# 2 = STOP_MISSION (para gravação)
int32 command

# --- Dados Adicionais ---
# Nome da missão (para START_MISSION) ou status final (para STOP_MISSION)
string data

