# mo_mysql-cookbook

Instala un servidor de Mysql master, slave o standalone. Cuando se utiliza
master/slave se llamará cluster al grupo de un master con N slaves

## IMPORTANTE

Cuando se configura mysql con esta receta, las conexiones con sockets dejan de
funcionar si no se configura de forma adecuada my.cnf. Sin embargo, librerías
como por ejemplo la gema mysql2, si no se especifica el socket, tratará de
buscar el por defecto del sistema y no lo encontrará. Por tanto, en vez de
conectarse con localhost, usar 127.0.0.1 que fuerza el uso de TCP

## Platformas soportadas

Todas? Nos manejamos con las recetas de:

  * [mysql](https://github.com/chef-cookbooks/mysql)
  * [mysql_tuning](https://github.com/onddo/mysql_tuning-cookbook)
  * [mysql-multi](https://github.com/rackspace-cookbooks/mysql-multi)

Por lo que dependemos de esas recetas

## Atributos

```
default['mo_mysql']['databag'] = 'mysql_clusters'
default['mo_mysql']['cluster_name'] = 'cluster_name'
default['mo_mysql']['master'] = nil
default['mo_mysql']['slaves'] = []
default['mo_mysql']['slave_user'] = 'slave'
default['mo_mysql']['server_repl_password'] = 'repl_mo_mysql_pass'
default['mo_mysql']['install_recipe'] = 'mo_mysql::mysql_server'
default['mo_mysql']['tmpdir']['dir'] = '/var/mysqltmp'
default['mo_mysql']['tmpdir']['size'] = '1G'
default['mysql_tuning']['tuning.cnf']['mysqld']['innodb_log_files_in_group'] = 2
default['mysql']['server_root_password'] = 'change-me'
```

### Qué es cada atributo

La configuracion de un cluster, se realiza a través de un data bag con el
formato siguiente (asumiendo que el cluster es cluster-01:


```
{
  "id": "cluster-01",
  "server_root_password": "root",
  "server_repl_password": "rootpass",
  "master": "mysql-master.vagrant.desarrollo.unlp.edu.ar",
  "slaves": ["mysql-slave.vagrant.desarrollo.unlp.edu.ar"],
  "superuser": "admin",
  "superuser_password": "superpass",
  "superuser_from_networks": "%"
}
```

Considerar que si no se setea master y slaves, se utilizará la búsqueda sobre el
servidor de chef (no funcionará con chef-solo)

* **databag**: nombre del data bag de donde se obtienen los valores para configurar
  el cluster.
* **cluster_name**: nombre del item de data bag de donde se leerán los datos
* **master**: nombre (fqdn) o ip del servidor que será master
* **slaves**: arreglo de nombres (fqdn) o ips de los servidores que serán slaves
* **slave_user**: usuario utilizado para la sincronización master/slave
* **install_recipe**: receta que instalará el servidor de mysql cuando se instale
 el cluster. Por defecto se utiliza: **mo_mysql::mysql_server**
* **server_repl_password**: password de sincronización
* **tmpdir dir**: directorio usado como tmpfs para mysql
* **tmpdir size**: cantidad de memoria usada para tmpfs
* **mysql_tuning tuning.cnf**: permite sobreescribir cualquier atributo de tuning
 utilizando las secciones como claves y alguna opción válida de my.cnf
* **mysql server_root_password**: password de root de mysql. Utilizado por
  compatibilidad con mysql < 6.0.0. Muchas recetas se basan en este atributo. Por 
  ello lo seteamos cuando se setea la password de root de mysql

## Uso

### mo_mysql::master

Instala el master de un cluster. Requiere de un databag para poder configurarse

### mo_mysql::slave

Instala el slave de un cluster. Requiere de un databag para poder configurarse

### mo_mysql::standalone-server

Instala un servidor de mysql básico sin tuning, tmpfs, ni binary logs. Sirve
para tests de recetas que requieran un server de mysql

## Librerías provistas

La receta provee de la funcionón: `mo_mysql_data_for_cluster`  que es un wrapper
para leer un databag según los atributos del nodo que indica el nombre del
databag. El nombre del cluster se recibe como parámetro

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## Autores

* Author:: Christian A. Rodriguez (<chrodriguez@gmail.com>)
* Author:: Leandro Di Tommaso (<leandro.ditommaso@mikroways.net>)
