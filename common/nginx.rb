# Custom username and password (pass that )
namespace :nginx do
  desc "Install gem dependencies using Bundler."
  task :install do
    comment %{Installing nginx}
    command %{sudo yum install -y nginx}
    command %{execute "iptables -F"}
  end

  task :test do
    queue! %[echo "-----> Creating shared directories"]
  end

  task :start do
    comment %{Starting nginx}
    command %{service nginx start}
  end

  task :stop do
    comment %{Stopping nginx}
    command %{service nginx stop}
  end
  # # delete all files from nginx conf
  # directory "/etc/nginx/conf.d" do
  #   recursive true
  #   action :delete
  # end
  # # create new conf.d directory
  # directory "/etc/nginx/conf.d" do
  #   action :create
  # end
  # # add custom nginx conf (by default owner is root)
  # template "/etc/nginx/conf.d/amber.conf" do
  #   source "nginx/nginx_default.erb"
  # end
end