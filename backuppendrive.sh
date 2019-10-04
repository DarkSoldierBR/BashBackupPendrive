#!/bin/bash


#####################################################
#|||||||||||||||||||||||||||||||||||||||||||||||||||#
#|#Script simples para backup feito por MATEUS DIAS|#
#|||||||||||||||||||||||||||||||||||||||||||||||||||#
#####################################################


loop=1

while [ $loop = 1 ] 
do


#variaveis configuráveis 
localbackup="/home/mateus/ETEC/" #local onde os arquivos do pendrive serão sincronizados
uid="184F39D627BEE814" #uuid do dispositivo
adicionar_pasta="ETEC" #pasta na raiz do pendrive que sera sincronizado 
tempoicacao=250   #(em segundos)
notificacoes= true #deveriftrue = com notificações,false = o script não enviara notificações.


#variaveis fixas(não mexer)
verificapendrive=$(lsblk --output UUID,MOUNTPOINT | grep "$uid" | awk '{print $1}') 


#confirmando
echo "Local do backup: $localbackup"
echo "UUID: $uid"

#verifica se o pendrive esta conectado
if [ $verificapendrive = $uid ]
then

echo "Pendrive encontrado"
$(notify-send "Pendrive encontrado")


#verifica se as notificações estão ativadas
	if [ $notificacoes = true ]
	then
	$(notify-send "Pendrive encontrado")
	fi 


mount_point_pendrive=$(lsblk --output UUID,MOUNTPOINT | grep "$uid" | awk '{print $2}') #localiza onde é o ponto de montagem do dispositivo
caminho=$mount_point_pendrive/$adicionar_pasta/* #monta um caminho de acordo com as variaveis mount_point_drive e adicionar_pasta
sincroniza=$(rsync -uahivP --delete $caminho $localbackup)





		if [ $notificacoes = true ]
		then
		$(notify-send "Backup Sincronizado")
		fi 


sleep $tempodeverificacao

else

echo "Pendrive não encontrado"

sleep $tempodeverificacao

fi 

done


