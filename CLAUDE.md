# Orientações para manutenção de `drone_inspetor_msgs`

Este arquivo orienta assistentes de código e contribuidores ao alterar o pacote.
O [README](README.md) explica sua finalidade, instalação, compilação e interfaces
disponíveis. Para iniciar os nós consumidores, consulte o
[guia de execução da aplicação](../drone_inspetor/docs/EXECUCAO.md).

## Escopo e fontes de referência

Este é um pacote `ament_cmake`/rosidl que gera contratos ROS 2. Não contém nós
executáveis nem launchers. Ele é dependência de `drone_inspetor`; os dois pacotes
devem usar a mesma linha `v2.0` e atualmente declaram versão `2.0.0`.

- As definições e comentários em [msg/](msg/), [srv/](srv/) e [action/](action/)
  determinam os campos, tipos, unidades e semântica dos contratos.
- [CMakeLists.txt](CMakeLists.txt) registra as interfaces geradas e dependências
  de compilação; [package.xml](package.xml) declara metadados e dependências ROS.
- O [contrato de coordenadas da aplicação](../drone_inspetor/docs/COORDENADAS.md)
  explica os referenciais usados pelos consumidores.

Consulte essas fontes antes de editar um contrato. Não mantenha aqui cópias das
tabelas de campos: elas podem divergir das interfaces. As flags de obstáculos
servem para apresentação; não comprovam espaço livre nem autorizam movimento.

## Alterar ou adicionar uma interface

1. Identifique os publicadores, assinantes, clientes e servidores afetados no
   `drone_inspetor`. Preserve nomes, significado, unidades e valores padrão quando
   possível; coordene mudanças incompatíveis com todos os consumidores.
2. Crie ou edite o arquivo em `msg/`, `srv/` ou `action/`. Siga a nomenclatura
   existente, como `NomeMSG.msg`, `NomeSRV.srv` e `DroneCommand.action`, e documente
   unidades, referenciais e tratamento de valores ausentes nos comentários.
3. Para um arquivo novo, acrescente seu caminho a `rosidl_generate_interfaces()`
   em `CMakeLists.txt`.
4. Se introduzir tipos de outro pacote, declare a dependência em `package.xml`,
   use `find_package(... REQUIRED)` em `CMakeLists.txt` e inclua o pacote em
   `DEPENDENCIES` de `rosidl_generate_interfaces()`.
5. Recompile as interfaces e os consumidores, carregue o overlay correto e
   reinicie os processos que usam os tipos gerados. Trocar a branch ou usar
   `--symlink-install` não dispensa recompilar as interfaces.
6. Confira os tipos gerados e execute os testes pertinentes da aplicação,
   conforme seu [README](../drone_inspetor/README.md). Atualize a documentação
   quando a mudança alterar o comportamento público.

## Verificação rápida

Com as dependências preparadas conforme o [README](README.md):

```bash
source /opt/ros/jazzy/setup.bash
cd ~/ros2_ws
colcon build --packages-select drone_inspetor_msgs
source install/setup.bash
ros2 interface show drone_inspetor_msgs/msg/DroneStateMSG
ros2 interface show drone_inspetor_msgs/action/DroneCommand
ros2 interface show drone_inspetor_msgs/srv/CVDetectionSRV
```

Esses comandos conferem a geração das interfaces; a validação dos consumidores
exige o build e os testes da aplicação. Ao comparar v1 e v2, use um terminal novo
e build/install isolados, conforme o README da aplicação.
