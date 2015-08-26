[1mdiff --git a/attributes/default.rb b/attributes/default.rb[m
[1mindex 9744e56..e300571 100644[m
[1m--- a/attributes/default.rb[m
[1m+++ b/attributes/default.rb[m
[36m@@ -16,3 +16,8 @@[m [mdefault['mysql']['server_root_password'] = 'change-me'[m
 # Define encoding.[m
 default['mo_mysql']['encoding']['charset'] = 'utf8'[m
 default['mo_mysql']['encoding']['collation'] = 'utf8_general_ci'[m
[32m+[m
[32m+[m[32m# Slow log query dump[m
[32m+[m[32mdefault['mo_mysql']['slowquery_analysis']['enabled'] = false[m
[32m+[m[32mdefault['mo_mysql']['slowquery_analysis']['mail_to'] = 'root'[m
[32m+[m[32mdefault['mo_mysql']['slowquery_analysis']['mail_subject'] = "Slow queries at #{node.fqdn}"[m
[1mdiff --git a/recipes/logrotate.rb b/recipes/logrotate.rb[m
[1mindex 496e648..608c24a 100644[m
[1m--- a/recipes/logrotate.rb[m
[1m+++ b/recipes/logrotate.rb[m
[36m@@ -9,10 +9,13 @@[m [mif node['mysql_tuning'] &&[m
   logrotate_app "mo-mysql-slowlog" do[m
     path      "/var/lib/mysql-#{node['mysql-multi']['service_name']}/#{relative}"[m
     options   %w(missingok delaycompress notifempty compress sharedscripts)[m
[31m-    frequency 'weekly'[m
[32m+[m[32m    frequency 'daily'[m
     minsize   '1M'[m
     rotate    52[m
     create    %W(660 mysql mysql).join ' '[m
[32m+[m[32m    if node['mo_mysql']['slowquery_analysis']['enabled'][m[41m [m
[32m+[m[32m      prerotate  "    mysqldumpslow /var/lib/mysql-#{node['mysql-multi']['service_name']}/#{relative} | mail #{node['mo_mysql']['slowquery_analysis']['mail_to']} -s #{node['mo_mysql']['slowquery_analysis']['mail_subject']}"[m
[32m+[m[32m    end[m
     postrotate "    mysql -e 'select @@global.long_query_time into @lqt_save; set global long_query_time=2000; select sleep(2); FLUSH LOGS; select sleep(2); set global long_query_time=@lqt_save;'"[m
   end[m
 [m
