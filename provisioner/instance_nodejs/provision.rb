# Require all files in common instead
require_relative "../../common/provision"
require_relative "../../common/nginx"
require_relative "../../common/git"
require_relative "../../common/nodejs"
require_relative "../../common/postgres"
require_relative "../../common/os"

set :user,                    "ec2-user"
set :port,                    "22"
set :forward_agent,           true
set :domain,                  "54.169.24.210"
set :identity_file,           "../../common_private/amber.pem"
set :term_mode,               nil
set :deploy_to,               "/srv/www/amber"
set :ssh_command,             "--login" # enables fowardin
# SSH keys must be only be readable by current user
# chmod 400 ./some.pem

desc "First time setup of the environment"
task :setup => :environment do
  # Switch to root user for installation
  command %{sudo su}
  
  # Set the Locales (for every new user and instance)
  comment %{Setting Locales}
  command %{export LANG=en_US.UTF-8}
  command %{export LANGUAGE=en_US.UTF-8}
  command %{export LC_COLLATE=C}
  command %{export LC_CTYPE=en_US.UTF-8}
  command %{source /etc/bashrc}

  # Update os packages
  invoke :'os:update_packages'

  # Install Dev tools
  invoke :'os:install_dev_tools'

  # Install Nginx
  invoke :'nginx:install'
  
  # Install Git
  invoke :'git:install'

  # Install Vim
  command %[yum install -y vim]  

  # Installing wget
  command %[yum install -y wget]  
  
  # Install Postgres
  invoke :'postgres:install_client'
  
  # Node js needed for javascript runtime. Compile JS.
  invoke :'nodejs:install'

  # Run chruby after this, as then it sets up the path variables
  # template "/etc/profile.d/ruby.sgoth" do
  #   source "general/ruby.erb"
  # end

  # Install Basic gems
  # bash "installing-gems" do
  #   code <<-EOH
  #     su - #{node.user.name} -c "exec bash"
  #     su - #{node.user.name} -c "gem install bundler -v 1.9.2"
  #     su - #{node.user.name} -c "gem install tmuxinator -v 0.6.10"
  #   EOH
  # end

  # Bashrc setup

  # Setup users and groups 
  # # creating group
  # group node.user.name do
  #   action :create
  # end

  # # shadow of password is created
  # user node.user.name  do
  #   password node.user.password
  #   home "/home/#{node.user.name}"
  #   gid node.user.name
  #   supports manage_home: true
  #   shell "/bin/bash"
  #   comment "Created by Chef"
  # end

  # # give sudo permissions to deployer
  # template "/etc/sudoers.d/deployer_group" do
  #   source "prod_app/user_group.erb"
  # end

  # # custom files are added using templates
  # template "home/#{node.user.name}/.bashrc" do
  #   source "general/bashrc.erb"
  #   owner node.user.name
  # end

  # ====================== SERVER SETUP
  # # add the notification script (755 is default)
  # template "/etc/notification.sh" do
  #   source "general/notification.erb"
  #   mode '0775'
  # end

  # # creating directories for app with owner as deployer
  # # 775 direcory available to deployer group
  # [node.base_path,node.path].each do |path|
  #   directory path do
  #     owner node.user.name
  #     group node.user.name
  #     mode '0775'
  #   end
  # end

  # Install Ruby

  # adding postgres path
  # execute "echo 'export PATH=/usr/pgsql-9.3/bin:$PATH' >> /home/#{node.user.name}/.bashrc" do
  #   user node.user.name
  # end

  # include_recipe amber::resque
  # include_recipe amber::resque_scheduler (include monit scripts in)

  # Install nginx
  # adding nginx to the deployer group
  # execute "usermod -a -G #{node.user.name} nginx"

  # Install unicorn

  # Test monit running properly
  # restarting monit
  # execute "service monit restart"


  # SELinux errors on nginx fix
  # http://axilleas.me/en/blog/2013/selinux-policy-for-nginx-and-gitlab-unix-socket-in-fedora-19/
  # SELinux issues with nginx
  # Before this something must be present in audit.log --- both the pid logging and http port loggins
  # error must be present in audit.log

  # yum install -y policycoreutils-{python,devel}

  # Run these multiple times

  # grep nginx /var/log/audit/audit.log | audit2allow -M nginx
  # semodule -i nginx.pp
  # usermod -a -G deployer nginx
  # chmod g+rx /srv

  # Can only be executed only after first deploys happens
  # yum install policycoreutils-python
  # There are SELinux ports that are blocked. We need to unlbock them
  # http://www.cyberciti.biz/faq/rhel-fedora-redhat-selinux-protection/
  # Check the SE linux logs. THere would be errors
  # sudo cat /var/log/audit/audit.log | grep nginx | grep denied
  # Temporarily go into SELinux permissive mode
  # setenforce 0
  # Walk through SELinux log and generate new SELinux policy module
  # grep httpd /var/log/audit/audit.log | audit2allow -M nginx
  # Install newly created SELinux module
  # semodule -i nginx.pp
  # Switch SELinux back into enforcing mode
  # setenforce 1
  # Later on make a custom policy and use that .. That contains all the correct booleans to be altered

  # In emergency
  # setenforce 0


  # Check instance working properly. If not then abort. Make reuqest and check each
  # Do memory profiling

  comment %[Finished Setting up instance]
end