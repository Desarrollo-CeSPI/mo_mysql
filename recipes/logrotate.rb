if node['mysql_tuning'] &&
    node['mysql_tuning']['logging.cnf'] &&
    node['mysql_tuning']['logging.cnf']['slow_query_log'] == 'ON' &&
    node['mysql_tuning']['logging.cnf']['slow_query_log_file']

  relative = node['mysql_tuning']['logging.cnf']['slow_query_log_file']

  logrotate_app "mo-mysql-slowlog" do
    path      "/var/lib/mysql-#{node['mysql-multi']['service_name']}/#{relative}"
    options   %w(missingok delaycompress notifempty compress sharedscripts)
    frequency 'weekly'
    minsize   '1M'
    rotate    52
    create    %W(660 mysql mysql).join ' '
    postrotate "    mysql -e 'select @@global.long_query_time into @lqt_save; set global long_query_time=2000; select sleep(2); FLUSH LOGS; select sleep(2); set global long_query_time=@lqt_save;"
  end

end
