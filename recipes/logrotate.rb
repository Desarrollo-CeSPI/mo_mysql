if node['mysql_tuning'] &&
    node['mysql_tuning']['logging.cnf'] &&
    node['mysql_tuning']['logging.cnf']["mysqld"] &&
    node['mysql_tuning']['logging.cnf']["mysqld"]['slow_query_log'] == 'ON' &&
    node['mysql_tuning']['logging.cnf']["mysqld"]['slow_query_log_file']

  relative = node['mysql_tuning']['logging.cnf']["mysqld"]['slow_query_log_file']

  package 'sharutils' # Installs uuencode script

  slow_log_file =  "/var/lib/mysql-#{node['mysql-multi']['service_name']}/#{relative}"

  logrotate_app "mo-mysql-slowlog" do
    path      slow_log_file
    options   %w(missingok delaycompress notifempty compress sharedscripts)
    frequency 'daily'
    minsize   '1M'
    rotate    52
    create    %W(660 mysql mysql).join ' '
    if node['mo_mysql']['slowquery_analysis']['enabled'] 
      prerotate  "    ( mysqldumpslow #{slow_log_file} ; gzip -c #{slow_log_file} | uuencode slow-query.log.gz  ) | mail #{node['mo_mysql']['slowquery_analysis']['mail_to']} -s '#{node['mo_mysql']['slowquery_analysis']['mail_subject']}'"
    end
    postrotate "    mysql -e 'select @@global.long_query_time into @lqt_save; set global long_query_time=2000; select sleep(2); FLUSH LOGS; select sleep(2); set global long_query_time=@lqt_save;'"
  end

end
