# =============================================================================
# Mensagem de Status da FSM (FSMStateMSG)
# Publicada pelo fsm_node para informar o estado atual da máquina de estados
# =============================================================================

# --- Estado Principal ---
uint8 state                                # Código do estado (FSMStateDescription enum)
string state_name                          # Nome do estado (ex: "EXECUTANDO_INSPECIONANDO")

# --- Flags de Missão ---
bool on_mission                            # True se uma missão está em execução
bool cancel_mission                        # True se cancelamento foi solicitado

# --- Missão Atual ---
string mission_name                        # Nome da missão carregada (de missions.json)
string mission_folder_path                 # Caminho completo da pasta da missão atual
float64 tempo_de_permanencia               # Tempo de permanência em cada ponto (segundos)

# --- Parâmetros de Configuração ---
float64 takeoff_altitude                   # Altitude de decolagem (metros)

# --- Controle de Waypoints ---
int32 ponto_de_inspecao_indice_atual       # Índice do ponto de inspeção atual (0-based)
int32 total_pontos_de_inspecao             # Número total de pontos de inspeção na missão
float64 ponto_de_inspecao_tempo_de_chegada # Timestamp de chegada ao ponto (0.0 se não chegou)
string objeto_alvo                         # Nome do objeto alvo no ponto atual (ex: "flare")
string[] tipos_anomalia                    # Lista de tipos de anomalia a buscar (ex: ["mild_corrosion", "severe_corrosion"])
