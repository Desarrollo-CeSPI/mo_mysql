service 'mysql' do
  supports :restart => true
end

file '/root/patch_mysql_restart' do
  action :create_if_missing
  notifies :restart, 'service[mysql]', :immediately
end

