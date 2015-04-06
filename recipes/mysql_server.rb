
directory node['mo_mysql']['tmpdir']['dir']

mount node['mo_mysql']['tmpdir']['dir'] do
  pass     0
  fstype   "tmpfs"
  device   "/dev/null"
  options  "rw,mode=1777,nr_inodes=10k,size=#{node['mo_mysql']['tmpdir']['size']}"
  action   [:mount, :enable]
end

mysql_service node['mysql-multi']['service_name'] do
  bind_address node['mysql-multi']['bind_address']
  port node['mysql-multi']['service_port']
  initial_root_password node['mysql-multi']['server_root_password']
  action [:create, :start]
end

mysql_tuning node['mysql-multi']['service_name'] do
  include_dir "/etc/mysql-#{node['mysql-multi']['service_name']}/conf.d"
  notifies :restart, "mysql_service[#{node['mysql-multi']['service_name']}]"
end

if node['platform'] == 'ubuntu'
  # Mysql wont start because apparmor blocks mysql tmpfs writes
  service "apparmor" do
    service_name 'apparmor'
    action :nothing
  end

  file "apparmor tmpfs mysql" do
    path "/etc/apparmor.d/local/mysql/#{node['mysql-multi']['service_name']}-tmpfs"
    owner 'root'
    group 'root'
    mode '0644'
    content <<-EOT
      #{node['mo_mysql']['tmpdir']['dir']}/ r,
      #{node['mo_mysql']['tmpdir']['dir']}/** rwk,
    EOT
    notifies :restart, "service[apparmor]", :immediately
  end
end

mysql_config 'tmpfs' do
  source 'tmpfs.cnf.erb'
  instance node['mysql-multi']['service_name']
  variables(:dir => node['mo_mysql']['tmpdir']['dir'])
  notifies :restart, "mysql_service[#{node['mysql-multi']['service_name']}]"
end


mysqlm_dot_my_cnf 'root' do
  passwd node['mysql-multi']['server_root_password']
end
