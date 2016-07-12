# -*- mode: ruby -*-

 required_plugins = %w( vagrant-librarian-chef-nochef vagrant-vbguest vagrant-share vagrant-omnibus)
 required_plugins.each do |plugin|
   system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
 end

Vagrant.configure("2") do |config|

  config.vm.box = "geerlingguy/ubuntu1604"
  config.omnibus.chef_version = :latest

  config.vm.network :forwarded_port, guest: 5000, host: 5000

  config.vm.provision :shell, inline: "ulimit -n 2048"

  config.vm.synced_folder ".", "/home/vagrant/flashcards"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks"]
    chef.add_recipe "apt"
    chef.add_recipe "nodejs"
    chef.add_recipe "vim"
    chef.add_recipe 'ruby_build'
    # chef.add_recipe 'nginx'
    # chef.add_recipe "postgresql"
    chef.add_recipe "rbenv::user"
    chef.add_recipe "rbenv::vagrant"
    # Install Ruby 2.2.1 and Bundler
    chef.json = {
      rbenv: {
        user_installs: [{
          user: 'vagrant',
          rubies: ["2.2.1"],
          global: "2.2.1",
          gems: {
            "2.2.1" => [ { name: "bundler" }]
          }
        }]
      }
    }
  end
end
