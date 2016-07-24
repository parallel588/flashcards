# -*- mode: ruby -*-

 required_plugins = %w( vagrant-librarian-chef-nochef vagrant-vbguest vagrant-share vagrant-omnibus)
 required_plugins.each do |plugin|
   system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
 end

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/trusty64"
  #config.vm.box = "geerlingguy/ubuntu1604"
  #config.omnibus.chef_version = :latest
  config.omnibus.chef_version = "12.3.0"
  config.vm.network :forwarded_port, guest: 5000, host: 5000

  config.vm.provision :shell, inline: "ulimit -n 2048"

  config.vm.synced_folder ".", "/home/vagrant/flashcards"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks"]
    chef.add_recipe "apt"
    chef.add_recipe "vim"

    chef.add_recipe "nodejs"

    chef.add_recipe "postgresql"
    chef.add_recipe "postgresql::server"

    chef.add_recipe "ruby_build"
    chef.add_recipe "ruby_rbenv::system"

    chef.json = {
      postgresql: {
        pg_hba: [
          {
            "type": "local",     "db": "all",       "user": "postgres",
            "addr": nil,         "method": "trust"
          },
          {
            "type": "local",     "db": "all",       "user": "all",
            "addr": nil,         "method": "md5"
          },
          {
            "type": "host",      "db": "all",       "user": "all",
            "method": "md5",     "addr": "127.0.0.1/32",
          },
          {
            "type": "host",      "db": "all",       "method": "md5",
            "user": "all",       "addr": "::1/128"
          },
          {
            "type": "local",     "db": "all",       "method": "trust",
            "user": "vagrant",   "addr": nil
          },
          {
            "type": "host",      "db": "all",       "method": "md5",
            "user": "all",       "addr": "192.168.248.1/24"
          }
        ],
        password: {
          postgres: "1234"
        }
      },
      rbenv: {
        rubies: ["2.3.1"],
        global: "2.3.1",
        gems: { "2.3.1": [{"name": "bundler"}]}
      }
    }
  end

  config.vm.provision :shell, path: 'vagrant_scripts/after_script.sh', privileged: false
end
