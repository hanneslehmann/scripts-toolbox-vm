# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "deb/jessie-amd64"
  config.vm.provider "virtualbox" do |v|
     v.memory = 2048
     v.cpus = 2
	 #v.customize ["modifyvm", :id, "--name"  , "toolbox_debian"]
	 #v.customize ["modifyvm", :id, "--name"  , "toolbox_debian"]
  end
  
  config.vm.hostname = "toolbox"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80,   host: 10080 # nginx
  config.vm.network "forwarded_port", guest: 1883, host: 11883 # Mosquitto (MQTT)
  config.vm.network "forwarded_port", guest: 3306, host: 13306 # mysql
  config.vm.network "forwarded_port", guest: 3306, host: 11313 # mysql
  config.vm.network "forwarded_port", guest: 55672, host: 15670 # RabbitMQ Admin
  config.vm.network "forwarded_port", guest: 5672, host: 15672 # RabbitMQ -AMQP 
  config.vm.network "forwarded_port", guest: 5671, host: 15671 # RabbitMQ -AMQP
  config.vm.network "forwarded_port", guest: 61613, host: 11613 # RabbitMQ -STOMP 
  config.vm.network "forwarded_port", guest: 61614, host: 11614 # RabbitMQ -STOMP
  config.vm.network "forwarded_port", guest: 6379, host: 16379 # redis
  config.vm.network "forwarded_port", guest: 27017,host: 17017 # mongodb
  config.vm.network "forwarded_port", guest: 1880, host: 11880 # node-red
  config.vm.network "forwarded_port", guest: 11313, host: 11313 # hugo
  config.vm.network "forwarded_port", guest: 8888, host: 18888 # jupyter
  config.vm.network "forwarded_port", guest: 8881, host: 18881 # redis commander
  config.vm.network "forwarded_port", guest: 8001, host: 18001
  config.vm.network "forwarded_port", guest: 8080, host: 18080 # gitlab GUI
  config.vm.network "forwarded_port", guest: 8081, host: 18081 # gitlab clone
  config.vm.network "forwarded_port", guest:5601, host: 15601 # kibana
  config.vm.network "forwarded_port", guest:9200, host: 19200 # elasticsearch
  config.vm.network "forwarded_port", guest:50070, host: 15070 # Hadoop
  config.vm.network "forwarded_port", guest:8088, host: 18088 # Hadoop
  config.vm.network "forwarded_port", guest:9393, host: 19393 # SpringXD
  config.vm.network "forwarded_port", guest:18080, host: 18880 # Spark UI
  config.vm.network "forwarded_port", guest:8084, host: 18084 # Spark Master UI
 


  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "private_network", type: "dhcp"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder ".", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "2048"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  
  # Some commands for checking VM
  # while sleep 10;  do date; df | grep sda; done
  # sudo du -sh /*

   
## Uncomment following line, if you have a central apt-cache server approx installed   
   config.vm.provision "shell", path: "init_repos.sh", privileged: true
   config.vm.provision "shell", path: "init_apt.sh", privileged: true
   config.vm.provision "shell", path: "init_base.sh", privileged: true
   config.vm.provision "shell", path: "install_rabbitMQ.sh", privileged: true
   config.vm.provision "shell", path: "install_mongoDB.sh", privileged: true
   config.vm.provision "shell", path: "install_redis.sh", privileged: true
   config.vm.provision "shell", path: "install_ruby.sh", privileged: true
   config.vm.provision "shell", path: "install_r.sh", privileged: true
   config.vm.provision "shell", path: "install_go.sh", privileged: true
   config.vm.provision "shell", path: "install_nodejs.sh", privileged: true
   #config.vm.provision "shell", path: "install_cassandra.sh", privileged: true
   #config.vm.provision "shell", path: "install_ocaml.sh", privileged: false
   config.vm.provision "shell", path: "install_gitlab.sh", privileged: true
   config.vm.provision "shell", path: "install_hugo.sh", privileged: true
   config.vm.provision "shell", path: "bootstrap.sh", privileged: true
   config.vm.provision "shell", path: "install_fluentd.sh", privileged: true
   config.vm.provision "shell", path: "install_springxd.sh", privileged: true
   config.vm.provision "shell", path: "install_spark.sh", privileged: true
   config.vm.provision "shell", path: "install_pythonlibs.sh", privileged: true
   config.vm.provision "shell", path: "install_ansible.sh", privileged: true
   config.vm.provision "shell", path: "clean-up.sh", privileged: true
end
