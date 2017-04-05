namespace :os do
  desc "Updating Packages"
  task :update_packages do
    comment %{Updating Packages}
    command %[yum update -y]
  end

  desc "Installing Dev Tools"
  task :install_dev_tools do
    comment %{Installing Dev Tools}
    command %[yum groupinstall -y 'Development Tools']
  end
  
  desc "Adding Swap Space"
  task :add_swap do
    # Adding swap space
    # swapon -s; 
    # df; 
    # sudo dd if=/dev/zero of=/swapfile bs=1024 count=1024k; 
    # sudo mkswap /swapfile; 
    # sudo swapon /swapfile; 
    # swapon -s; 
    # sudo vi /etc/fstab; // write "/swapfile          swap            swap    defaults        0 0"
    # sudo chown root:root /swapfile; 
    # sudo chmod 0600 /swapfile; 
    # swapon -s; 
    # free -m;
  end

  # Enable epel repos
  # wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  # sudo rpm -Uvh epel-release-7*.rpm

end
