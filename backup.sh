#!/bin/bash

host=<IP_MASTER>
host_slave=<IP_SLAVE>
usuario=<USUARIO>
senha=<SENHA>

home_dir=/opt/ROTINA_BACKUP_DB/


data=$(date +%Y%m%d_%H%M%S)
echo "Inicio --- "$data

#LEITURA DA LINHA COM O NOME DOS BANCOS DE DADOS
for banco in $(cat $home_dir/bancos.txt)
do
	file_name=$home_dir/arquivos/$banco"_"$data.sql
	echo $banco"_"$data
	mysqldump -h $host -u $usuario --add-drop-database --complete-insert --no-tablespaces --databases $banco > $file_name
	mysql -h $host_slave -u root < $file_name
	tar -zcvf $file_name.tar.gz $file_name --remove-files
done

echo "Fim ---"$(date +%Y%m%d_%H%M%S)

#1. BACKUP REMOTO DO BANCO
#2. PREPARACAO DO ARQUIVO PARA IMPORTACAO
#3. IMPORTACAO DO ARQUIVO assjur 

#g4@n@d@
