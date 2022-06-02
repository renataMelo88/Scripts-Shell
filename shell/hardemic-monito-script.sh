#!/usr/bin/env bash

echo "ASSISTENTE DE INSTALAÇÃO HARDEMIC"

sudo apt update -y
sudo apt install zip -y

menu(){
echo "====== Opções de uso: ======"
echo ""
echo "1. CLI"
echo "2. GUI"
echo "3. DOCKER"
echo "4. DOCKER-COMPOSE"
echo ""
echo "============================"

read -p "Escolha uma opção: " opcao

installjava(){
  which java | grep /usr/bin/java

  if [ $? -ne 0 ]
  then


    sdk v

    if [ $? -ne 0 ]
    then
      curl -s "https://get.sdkman.io" | bash

      source "/home/$USER/.sdkman/bin/sdkman-init.sh"

      sdk install java  11.0.14.10.1-amzn

    fi
  fi

  mvn -v

  if [ $? -ne 0 ]
  then
    sudo apt install maven -y
  fi
}

installdocker(){
  docker -v

  if [ $? -ne 0 ]
  then
     sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg -y

    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update

    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

    sudo docker run hello-world

    sudo docker run -p 3306:3306 --name database -e "MYSQL_DATABASE=hardemic" -e "MYSQL_ROOT_PASSWORD=root" hardemic/database

    sudo docker exec -it awesome_herschel bash


    sleep 1

    sudo usermod -aG docker $USER

    clear
  fi

  sudo systectl start docker

  sudo service docker start

}

case $opcao in
1) echo "=== CLI ==="

   installjava

  cd ~/

  curl -O https://hardemic-pi.s3.amazonaws.com/hardemic.jar

# Executando o jar
  java -jar hardemic.jar cli
  clear
  ;;

2) echo "=== GUI ==="
   installjava

   cd ~/

   curl -O https://hardemic-pi.s3.amazonaws.com/hardemic.jar

   java -jar hardemic.jar

  clear

  java -jar hardemic-1.0-jar-with-dependencies.jar
  ;;
3) echo "=== DOCKER ==="
   installdocker

   sudo docker run -it --hostname $HOSTNAME hardemic/monitor

  ;;
4) echo "=== DOCKER-COMPOSE ==="
   installdocker

   docker-compose -v

   if [ $? -ne 0 ]
   then
    sudo apt-get install docker-compose -y
   fi

   cd ~/

   curl -O https://hardemic-pi.s3.amazonaws.com/docker-compose.yaml

   sudo docker-compose build && sudo docker-compose run app

*) echo "Opção $opcao Inválida!"
   sleep 1
   menu
  ;;
esac
}

menu

