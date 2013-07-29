# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

aws_config = YAML.load_file('aws.yml')["aws"]

Vagrant.configure("2") do |config|

  config.vm.provider :aws do |aws|
    config.vm.box     = "dummy"
    config.vm.box_url = "http://dev.nemac.org/boxes/dummy.box"
  end

  config.vm.provider :aws do |virtualbox|
    config.vm.box     = "centos-6.4-base"
    config.vm.box_url = "http://dev.nemac.org/boxes/CentOS-6.4-base.box"
  end

  #####################################################3
  config.vm.provider :aws do |aws, override|
    aws.instance_type             = aws_config["instance_type"]
    aws.instance_name             = aws_config["instance_name"]
    aws.access_key_id             = aws_config["access_key_id"]
    aws.secret_access_key         = aws_config["secret_access_key"]
    aws.keypair_name              = aws_config["keypair_name"]
    aws.security_groups           = aws_config["security_groups"]

    aws.ami                       = "ami-4690ea2f"
    # This is a custom AMI which I created by doing the following:
    #   1. subscribe to the AWS MarketPlace "CentOS with updates" image (in the MarketPlace, but free)
    #   2. fire up an instance using the AMI subscribed in step 1, then ssh to it
    #   3. remove the "requiretty" line from /etc/sshd/config (or some such)
    #   4. disable SELinux
    #   5. rm /root/.ssh/authorized_keys
    #   6. back at the AWS console, select the instance and choose "Create Image" to create the AMId

    override.ssh.username         = "root"
    override.ssh.private_key_path = aws_config["keypair_name"] + ".pem"
  end
  #####################################################3

  config.vm.synced_folder "./puppet", "/etc/puppet/files"

  config.vm.provision :shell, :inline => <<-HEREDOC
    rpm -Uvh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm
    yum -y install puppet
    rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
  HEREDOC

  config.vm.provision :puppet,
    :options => ["--fileserverconfig=/vagrant/puppet/fileserver.conf"] do
      |puppet|
    puppet.module_path    = "puppet/modules"
    puppet.manifests_path = "puppet"
    puppet.manifest_file  = "site.pp"
  end

  config.vm.network :private_network, ip: "192.168.33.20"

end
