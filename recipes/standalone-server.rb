mysql_service 'default' do
  initial_root_password node['mysql']['server_root_password']
  socket node['mo_mysql']['socket_file']
  action [:create, :start]
end

mysqlm_dot_my_cnf 'root' do
  passwd node['mysql']['server_root_password']
end
