include_recipe "mo_mysql::_reqs"
include_recipe "mysql-multi::mysql_master"
include_recipe "mo_mysql::_patch_restart"
