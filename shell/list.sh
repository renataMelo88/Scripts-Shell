#!/bin/bash


which java | grep /usr/bin/java

if [ $? = 0 ]
then echo “OK”
else echo “Não OK”
fi

java -version
if [ $? -eq 0 ]
then
echo \"java instalado\"
else
echo \"java não instalado\"
echo \"gostaria de instalar o java? S/n \" 
read inst
if [ \"$inst\" == \"s\" ]
then
echo \"voce escolheu instalar o java\"
echo \"instalado repositorio\"
sleep 2
add-apt-repository ppa:webupd8team/java -y
clear
echo \"Atualizando repositorio\"
sleep 2
apt-get update -y
clear
echo \"escolha a versão que deseja instalar 7 ou 8\"
read versao
if [ \"$versao\" == "7" ]
then
echo \"escolheu a versão 7, preparando para instalar\"
apt-get install oracle-java7-installer -y
clear
echo \"java instalado versão 7\"
elif [ \"$versao\" == "8" ]
then
echo \"escolheu a versão 8, preparando para instalar\"
sudo apt-get install oracle-java8-installer -y
 -y
clear
echo \"java instalado versão 8\"
else
echo \"versão não identificada\"
fi
else echo \"você escolheu não instalar\"
fi
fi
 
