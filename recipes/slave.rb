include_recipe "cespi_mysql::_reqs"
include_recipe "mysql-multi::mysql_slave"
include_recipe "cespi_mysql::_patch_restart"
