def mo_mysql_data_for_cluster(cluster_name)
  data_bag_item(node['mo_mysql']['databag'], cluster_name).tap do |data|
    Chef::Log.info("Loaded data for Mysql cluster #{node['mo_mysql']['databag']}/#{cluster_name}")
    data['type'] = 'mysql'
  end
end

