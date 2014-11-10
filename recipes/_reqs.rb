cluster_name = node['mo_mysql']['cluster_name']

data = data_bag_item(node['mo_mysql']['databag'], cluster_name)

Chef::Application.fatal! "Databag #{node['mo_mysql']['databag']}/#{cluster_name} must define a section for node environment [#{node.chef_environment}] " unless data[node.chef_environment]

data = data[node.chef_environment]

node.set['mysql']['server_root_password']       = data['server_root_password'] if data['server_root_password']
node.set['mysql']['server_debian_password']     = data['server_debian_password'] if data['server_debian_password']
node.set['mysql-multi']['server_repl_password'] = data['server_repl_password'] if data['server_repl_password']
node.set['mysql-multi']['templates']['my.cnf']['cookbook'] = 'mo_mysql'