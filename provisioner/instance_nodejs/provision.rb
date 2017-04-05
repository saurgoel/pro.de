# Require all files in common instead
require_relative "../../common/provision"
require_relative "../../common/nginx"
require_relative "../../common/git"
require_relative "../../common/nodejs"
require_relative "../../common/postgres"
require_relative "../../common/os"
require_relative "../../common/ruby"

# ------------------------- SSH PARAMS
set :user,                    "ec2-user"
set :port,                    "22"
set :forward_agent,           true
set :domain,                  ""
set :identity_file,           "../../common_private/test.pem"
set :term_mode,               nil
set :ssh_command,             "--login" # enables fowardin
# SSH keys must be only be readable by current user
# chmod 400 ./some.pem

# ------------------------- INSTANCE SETUP PARAMS
set :main_user_name,          "deployer"
set :main_user_password,      "deployer"
set :main_group,              "deployer"



# ------------------------- TASKS
desc "First time setup of the environment"
task :setup => :environment do
  # Switch to root user for installation
  # command %{sudo su -}
  
  # Set the Locales (for every new user and instance)
  invoke :'os:set_locales'
  
  # Update os packages
  invoke :'os:update_packages'

  # Install Dev tools
  invoke :'os:install_dev_tools'

  # Bashrc setup

  # Setup users and groups
  invoke :'os:users:create', user_name: fetch(:main_user_name), user_password: fetch(:main_user_password)
  invoke :'os:groups:create'

  # give sudo permissions to deployer
  # %<%= node.user.name %> ALL=(ALL) ALL
  # template "/etc/sudoers.d/deployer_group" do
  #   source "prod_app/user_group.erb"
  # end

  # custom files are added using templates
  # template "home/#{node.user.name}/.bashrc" do
  #   source "general/bashrc.erb"
  #   owner node.user.name
  # end

  # Installing ruby and rubygems
  # Options to install a specific ruby version
  invoke :'ruby:install'
  invoke :'rubygems:install'
  # Install global gems
  # command %{su - #{node.user.name} -c "exec bash"}
  # command %{su - #{node.user.name} -c "gem install bundler -v 1.9.2"}
  # command %{su - #{node.user.name} -c "gem install tmuxinator -v 0.6.10"}
  # Run chruby after this, as then it sets up the path variables
  # template "/etc/profile.d/ruby.sgoth" do
  #   source "general/ruby.erb"
  # end

  # Install Nginx
  invoke :'nginx:install'
  
  # Install Git
  invoke :'git:install'

  # Install Vim
  command %{sudo yum install -y vim}

  # Installing wget
  command %{sudo yum install -y wget}
  
  # Install Postgres
  invoke :'postgres:install_client'
  
  # Node js needed for javascript runtime. Compile JS.
  invoke :'nodejs:install'


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

  # adding postgres path
  # execute "echo 'export PATH=/usr/pgsql-9.3/bin:$PATH' >> /home/#{node.user.name}/.bashrc" do
  #   user node.user.name
  # end

  # adding nginx to the deployer group
  # execute "usermod -a -G #{node.user.name} nginx"

  # Install unicorn

  # Test monit running properly
  # restarting monit
  # execute "service monit restart"


  # Check instance working properly. If not then abort. Make reuqest and check each
  # Do memory profiling

  comment %[Finished Setting up instance]
end