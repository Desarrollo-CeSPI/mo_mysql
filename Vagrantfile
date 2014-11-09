# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.5.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.define 'mysql-master', primary: true do |app|
    app.vm.hostname = "mysql-master.vagrant.desarrollo.unlp.edu.ar"
    app.omnibus.chef_version = :latest
    app.vm.box = "chef/debian-7.4"
    app.vm.network :private_network, ip: "10.100.4.2"
    app.berkshelf.enabled = true
    app.vm.provision :chef_solo do |chef|
      chef.log_level = :debug
      chef.data_bags_path = 'sample/data_bags'
      chef.environment = 'production'
      chef.environments_path = 'sample/environments'
      chef.json = {
        mo_mysql: {
          bind_ip: "10.100.4.2",
          cluster_name: 'cluster_vagrant'
        },
        "mysql-multi" => {
          slaves: ['10.100.4.3']
        }
      }
      chef.run_list = [
        "recipe[apt::default]",
        "recipe[mo_mysql::master]",
        "recipe[role_db_cluster::cluster_01]"
      ]
    end
  end

  config.vm.define 'mysql-slave' do |app|
    app.vm.hostname = "mysql-slave.vagrant.desarrollo.unlp.edu.ar"
    app.omnibus.chef_version = :latest
    app.vm.box = "chef/debian-7.4"
    app.vm.network :private_network, ip: "10.100.4.3"
    app.berkshelf.enabled = true
    app.vm.provision :chef_solo do |chef|
      chef.data_bags_path = 'sample/data_bags'
      chef.environment = 'production'
      chef.environments_path = 'sample/environments'
      chef.json = {
        mo_mysql: {
          bind_ip: "10.100.4.3",
          cluster_name: 'cluster_vagrant'
        },
        "mysql-multi" => {
          master: '10.100.4.2'
        }
      }
      chef.run_list = [
        "recipe[apt::default]",
        "recipe[mo_mysql::slave]"
      ]
    end
  end
end
