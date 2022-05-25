#!bin/bash

echo "ASSISTENTE DE INSTALAÇÃO HARDEMIC"

# sudo apt update -y

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
  # Verificando se o java já está instalado => retorna 0 se estiver
  which java | grep /usr/bin/java
  # Se o resultado do comando anterior não for igual a 0
  if [ $? -ne 0 ]
  then
    # Instala o zip
    sudo apt install zip -y
    # Verifica se o sdkman está instalado
    sdk v
    # Se o resultado do comando anterior não for igual a 0
    if [ $? -ne 0 ]
    then
    # Instala o sdkman
      curl -s "https://get.sdkman.io" | bash

      source "/home/$USER/.sdkman/bin/sdkman-init.sh"
    # Instala o jdk11
      sdk install java  11.0.14.10.1-amzn

    fi
  fi
  # Verifica se o maven está instalado

  mvn -v
  # Se o resultado do comando anterior não for igual a 0

  if [ $? -ne 0 ]
  then
 # Instala o maven
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


    sudo apt-get update

    sudo apt install docker.io

    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

    sudo docker run hello-world



    sleep 1

    sudo usermod -aG docker $USER

    clear
  fi

  sudo systemctl docker start
  sudo systemctl docker enable

  sudo docker pull mysql:5.7

  echo "Vamos executar o conteiner que contém o mysql"

  sudo docker run -d -p 3306:3306 --name ConteinerBD -e "MYSQL_DATABASE=banco1"-e"MYSQL_ROOT_PASSWORD=urubu100" mysql:5.7
  sudo docker run java-docker
}

case $opcao in
1) echo "=== CLI ==="
# Chamando a função para instalar o java
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

   java -jar target/hardemic.jar

   clear
  ;;
3) echo "=== DOCKER ==="
   installdocker

   cd ~/

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

   sudo docker-compose run app
  ;;
*) echo "Opção $opcao Inválida!"
   sleep 1
            
  menu
  ;;
esac
}

menu
