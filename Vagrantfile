# Install: vagrant plugin install vagrant-qemu

Vagrant.configure("2") do |config|
  # Ubuntu 22.04 LTS (Jammy)
  config.vm.box = "perk/ubuntu-2204-arm64"
  
  config.vm.hostname = "anton-dev"
  
  config.vm.provider "qemu" do |qe|
    qe.arch = "aarch64"
    qe.machine = "virt,gic-version=max" 
    qe.cpu = "max"
    qe.memory = "4G"
    qe.smp = "cpus=2,sockets=1,cores=2,threads=1"
    qe.net_device = "virtio-net-pci"
    
    # SSH forwarding
    qe.ssh_port = 50022
    
    # Extra QEMU arguments for better performance
    qe.extra_qemu_args = %w(-accel hvf)
  end
  
  # Network configuration
  # Port forwarding for common services
  config.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh", auto_correct: true
  config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
  config.vm.network "forwarded_port", guest: 443, host: 8443, auto_correct: true
  
  # Sync folders
  config.vm.synced_folder ".", "/vagrant", type: "rsync",
    rsync__exclude: [".git/", "server-capture-*/", ".DS_Store"]
  
  # Shell provisioning for basic setup
  config.vm.provision "shell", inline: <<-SHELL
    # Update and install Python for Ansible
    apt-get update
    apt-get install -y python3 python3-pip
    
    # Create storage directory to simulate production
    mkdir -p /mnt/external_hdd
    chmod 755 /mnt/external_hdd
  SHELL
  
  # Ansible provisioning
  config.vm.provision "ansible" do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.playbook = "ansible/playbook.yml"
    ansible.inventory_path = "ansible/inventory"
    ansible.limit = "all"
    ansible.verbose = "v"
    ansible.extra_vars = {
      ansible_python_interpreter: "/usr/bin/python3",
      # Override for dev environment
      host_user: "vagrant",
      host_dir: "/mnt/external_hdd",
      # Architecture-specific overrides for QEMU (arm64 box)
      docker_repo_arch: "arm64",
      docker_compose_arch: "aarch64",
      node_exporter_arch: "arm64"
    }
  end
end
