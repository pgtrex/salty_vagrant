# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  ## Choose your base box
  config.vm.box = "ubuntu/trusty64"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # You can change this to anything you want, just make sure it matches in the wordpress.sls file
  config.vm.network :private_network, ip: "10.10.20.10"

  ## For masterless, mount your file roots file root
  config.vm.synced_folder "salt/", "/srv/"

  ## Set your salt configs here
  config.vm.provision :salt do |salt|

    ## Minion config is set to ``file_client: local`` for masterless
    salt.minion_config = "salt/minion.yml"

    ## Installs our example formula in "salt/roots/salt"
    salt.run_highstate = true

  end
end
