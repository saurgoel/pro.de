namespace :supervisor do
  task :install do
    comment %{Installing Supervisor}
    execute %{yum install python-setuptools -y}
    execute %{yum install python-setuptools-devel -y}
    execute %{easy_install supervisor}
  end
end

# Adding the config files
# We are using the config in app
# template "/etc/supervisord.conf" do
#   source "supervior/base.erb"
# end

# fle to start supervior at system restart

# Memcached
[program:memcached]
command=/usr/local/bin/memcached -p 11211 -u memcached -m 256 -c 1024 -t 4
autostart=true
autorestart=true
user=root
priority=100
redirect_stderr=true
stdout_logfile=/var/log/memcached/stdout.log

# Nginx
[program:nginx]
command = /etc/init.d/nginx
autostart=true
autorestart=unexpected
exitcodes=0