default['mo_mysql']['databag'] = 'mysql_clusters'
default['mo_mysql']['cluster_name'] = 'cluster_name'
default['mo_mysql']['master'] = nil
default['mo_mysql']['slaves'] = []
default['mo_mysql']['slave_user'] = 'slave'
default['mo_mysql']['server_repl_password'] = 'repl_mo_mysql_pass'
default['mo_mysql']['install_recipe'] = 'mo_mysql::mysql_server'
default['mo_mysql']['tmpdir']['dir'] = '/var/mysqltmp'
default['mo_mysql']['tmpdir']['size'] = '1G'
default['mo_mysql']['socket_file'] = '/var/run/mysqld/mysqld.sock'
default['mysql_tuning']['tuning.cnf']['mysqld']['innodb_log_files_in_group'] = 2

# This attribute is to preserve compatibility issues related to the old mysql opscode recipe where 
# root password was an attribute of the node
default['mysql']['server_root_password'] = 'change-me'
