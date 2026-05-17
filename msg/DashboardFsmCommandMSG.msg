# Comando do Dashboard para FSM
# Usa código inteiro para eficiência e type-safety

# Código do comando (ver DashboardFsmCommandDescription enum)
int32 command

# Parâmetros opcionais dependendo do comando:

# Para INICIAR_MISSAO - nome da missão a executar (deve existir em missions.json)
string mission
