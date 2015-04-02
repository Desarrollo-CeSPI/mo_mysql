data = mo_mysql_data_for_cluster node['mo_mysql']['cluster_name']

fatal "You must set server_root_password for mysql" unless data['server_root_password']
node.set['mysql']['server_root_password']       = data['server_root_password']
node.set['mysql-multi']['server_root_password'] = data['server_root_password']
node.set['mysql-multi']['slave_user']           = data['slave_user'] if data['slave_user']
node.set['mysql-multi']['server_repl_password'] = data['server_repl_password'] if data['server_repl_password']
node.set['mysql-multi']['install_recipe']       = node['mo_mysql']['install_recipe']
node.set['mysql-multi']['templates']['my.cnf']['cookbook'] = 'mo_mysql'
node.set['mo_mysql']['socket_file']             = "/var/run/mysqld-#{node['mysql-multi']['service_name']}/mysqld.sock"

include_recipe 'build-essential::default'

mysql2_chef_gem 'default' do
  action :install
end

mysql_client 'default' do
    action :create
end
