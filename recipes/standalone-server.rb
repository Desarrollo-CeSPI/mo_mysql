mysql_service 'standalone' do
  initial_root_password node['mysql']['server_root_password']
  action [:create, :start]
end

mysqlm_dot_my_cnf 'root' do
  passwd node['mysql']['server_root_password']
end
