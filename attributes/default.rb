default['mo_mysql']['databag'] = 'mysql_clusters'
default['mo_mysql']['cluster_name'] = 'cluster_name'
default['mo_mysql']['master'] = nil
default['mo_mysql']['slaves'] = []
default['mo_mysql']['slave_user'] = 'slave'
default['mo_mysql']['server_repl_password'] = 'repl_mo_mysql_pass'
default['mo_mysql']['install_recipe'] = 'mo_mysql::mysql_server'
default['mo_mysql']['tmpdir']['dir'] = '/var/mysqltmp'
default['mo_mysql']['tmpdir']['size'] = '2G'
default['mysql_tuning']['tuning.cnf']['mysqld']['innodb_log_files_in_group'] = 2

# This attribute is to preserve compatibility issues related to the old mysql opscode recipe where 
# root password was an attribute of the node
default['mysql']['server_root_password'] = 'change-me'

# Define encoding.
default['mo_mysql']['encoding']['charset'] = 'utf8'
default['mo_mysql']['encoding']['collation'] = 'utf8_general_ci'

# Slow log query dump
default['mo_mysql']['slowquery_analysis']['enabled'] = false
default['mo_mysql']['slowquery_analysis']['mail_to'] = 'root'
default['mo_mysql']['slowquery_analysis']['mail_subject'] = "Slow queries at #{node.fqdn}"
