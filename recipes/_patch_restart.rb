service 'mysql' do
    #Bug in 14.04 for service provider. Adding until resolved.
    if (platform?('ubuntu') && node['platform_version'].to_f >= 14.04)
        provider Chef::Provider::Service::Upstart
    end
  supports :restart => true
end

file '/root/patch_mysql_restart' do
  action :create_if_missing
  notifies :restart, 'service[mysql]', :immediately
end

