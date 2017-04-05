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
