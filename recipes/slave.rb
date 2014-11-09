include_recipe "mo_mysql::_reqs"
include_recipe "mysql-multi::mysql_slave"
include_recipe "mo_mysql::_patch_restart"
