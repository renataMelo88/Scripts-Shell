#!/bin/bash

echo “Defina a senha urubu100 para os usuários root, ubuntu e crie o usuário urubu100”
  sudo passwd root

  sudo passwd ubuntu

  sudo addsuer urubu100


echo “Acesse o usuário root, e adicione o usuário urubu100, ao grupo sudoers para que tenha permissão de utilizar o comando sudo na execução dos comandos”

sudo usermod -aG sudo urubu100


echo "Atualize os pacotes do sistema operacional"
sudo apt-get update && sudo apt-get upgrade


echo "Agora, vamos instalar a interface gráfica"

 sudo apt install nmon


echo "Agora vamos baixar o Java"
sudo apt install zip
curl -s "https://get.sdkman.io" | bash
source "/home/urubu100/.sdkman/bin/sdkman-init.sh"
sdk install java 11.0.14.10.1-amzn


echo "Verfique a versão"
javac -version
 


echo "Agora vamos atualizar os pacotes e em seguida baixar o Docker"
sudo apt update
sudo apt install docker.io

echo "Agora vamos usar o gerenciador de processos do linux o systemctl para iniciar o Docker"
sudo systemctl start docker
sudo systemctl enable docker
systemctl -t service

echo "Vamos ver a versão do Docker"
docker –version

echo "Vamos instalar uma imagem do mysql"
sudo docker pull mysql:5.7

echo "Vamos executar o conteiner que contém o mysql"
sudo docker run -d -p 3306:3306 --name ConteinerBD -e "MYSQL_DATABASE=banco1"-e"MYSQL_ROOT_PASSWORD=urubu100" mysql:5.7
sudo docker stats ConteinerBD


