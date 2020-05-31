#!/bin/bash
#
###################################################################
#uso: ./backup.sh						                                      #
#								                                                  #
#descrição: realiza backup do diretorio corrente		              #
#do usuario(whoami), por padrao sera criado um arquivo compactado #
#em tar, no diretorio /home/users/ .				                      #
#								                                                  #
#autor: Pedro henrique					                                  #
#						                                                		  #
###################################################################
#
#
echo " ############################################### "
echo " ***************** BACKUP ********************** "
echo " ############################################### "
echo
DATAATUAL=$(date +%Y%m%d%H%M)
USUARIO=$(whoami)
PASTCON=$(echo "$PASTA" | cut -c7,8)

echo " verificando pasta backup "
echo
if ls /home/"$USUARIO"/ | grep "^Backup" > /dev/null
then
	echo "Pasta encontrada"
else
	echo "Pasta nao encontrada!"
	echo -n "criando pasta."
	sleep 1
	echo -n "."
	sleep 1
	echo -n "."
        mkdir /home/"$USUARIO"/Backup
      	echo
	echo "Pasta criada com sucesso "
fi
echo
echo "verificando arquivos..."

VERIFARQDAY=$(find "$HOME/Backup" -ctime -7 -name backup_home_*tgz)

if [ "$VERIFARQDAY" ]
then
	echo "existe um backup feito nos ultimos 7 dias "
	echo -n "deseja continuar(S/N): "
	read -n1 USUARIO
	echo
	if [ "$USUARIO" = "N" -o "$USUARIO" = "n" -o "$USUARIO" = "" ]
	then
		echo "Backup abortado! "
		exit 1
	elif [ "$USUARIO" = "S" -o "$USUARIO" = "s" ]
	then
		echo "seu backup sera criado em instantes.."
		sleep 4
	else
		echo "opçao invalida! "
		exit 2
	fi
fi

echo -n "criando backup."
sleep 1
echo -n "."
sleep 1
echo -n "."
sleep 1
echo -n "."
echo 
echo 
echo -n "Podera levar min para concluir."
sleep 1
echo -n "."
sleep 1 
echo -n "."
sleep 1
echo -n "."
echo
ARQ="backup_home_$(date +%Y%m%d%H%M).tgz"
tar zcpf "$HOME/Backup"/$ARQ "$HOME"/* > /dev/null
echo "O backup de nome \"backup_home_$DATAATUAL.tgz\" foi criado em \"$HOME/Backup"
echo
echo "backup concluido!"

