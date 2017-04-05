require "byebug"

desc "Set Basic Locales"
task :'os:set_locales' do
  comment %{Setting Locales}
  command %{export LANG=en_US.UTF-8}
  command %{export LANGUAGE=en_US.UTF-8}
  command %{export LC_COLLATE=C}
  command %{export LC_CTYPE=en_US.UTF-8}
  command %{source /etc/bashrc}
end

desc "Updating Packages"
task :'os:update_packages' do
  comment %{Updating Packages}
  command %[sudo yum update -y]
end

desc "Installing Dev Tools"
task :'os:install_dev_tools' do
  comment %{Installing Dev Tools}
  command %[sudo yum groupinstall -y 'Development Tools']
end

desc "Adding Swap Space"
task :'os:add_swap' do
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

desc "Enable EPEL Repos"
task :'os:enable_epel' do
  # wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  # sudo rpm -Uvh epel-release-7*.rpm
end


# http://www.tecmint.com/add-users-in-linux/
# useradd -u 12345 -g users -d /home/username -s /bin/bash -p $(echo mypasswd | openssl passwd -1 -stdin) username
task :'os:users:create', :params do |t, args|
  comment %{Creating user}
  command_arr = ["useradd"]
  unless args[:params][:user_name]
    puts "Task 'rvm:use' needs user_name argument."
    exit 1
  end
  if args[:params][:user_password]
    command_arr.push("-p", args[:params][:user_password])
  end
  # Check if user already present
  command_arr.push(args[:params][:user_name])
  command command_arr.join(" ")
end

task :'os:groups:create' do
  comment %{Creating group}
  command %{sudo useradd}
end
