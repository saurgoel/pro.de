execute 'yum install monit -y'

template "/etc/monit.d/base" do
  source "monit/base.erb"
end

# yum install monit -y
# service monit start
# chkconfig monit on

# ============= MONIT WEB INTERFACE
# # monit conf for httpd light webserver
# set httpd port 2812 and (required for monit web server interface)
# use address localhost  # only accept connection from localhost ( address of web server)
# allow localhost        # allow localhost to connect to the server and
# allow admin:monit      # require user 'admin' with password 'monit' (username and password)
# allow @monit           # allow users of group 'monit' to connect (rw)
#  allow @users readonly  # allow users of group 'users' to connect readonly

# =========== ADDING SERVICES TO MONIT
# These will run automatically when the system restarts or process kills
# add this to monit.conf file
# Also can be added to a file in /etc/monit.d directory

# check if  config is ok
#  monit -t


# restart monit
# service monit restart
# start monit daemon
# monit

# check monit log
# tail -f /var/log/monit



check process redis
  with pidfile /var/run/redis/redis.pid
  start program = "/etc/init.d/redis start"
  stop program = "/etc/init.d/redis stop"
  if 10 restarts within 10 cycles
    then timeout
  if failed host 127.0.0.1 port 6379 then restart


check process memcached with pidfile /var/run/memcached/memcached.pid
    start program = "/etc/init.d/memcached start"
    stop program = "/etc/init.d/memcached stop"
    if failed host 127.0.0.1 port 11211 then restart
    if cpu > 70% for 2 cycles then alert
    if cpu > 98% for 5 cycles then restart
    if 2 restarts within 3 cycles then timeout


<!-- http://www.guguncube.com/2959/monit-url-http-and-elasticsearch-checks -->
check process elasticsearch with pidfile /var/run/wistia-doc/elasticsearch.pid
   start program  "/etc/init.d/elasticsearch start"
   stop program  "/etc/init.d/elasticsearch stop"
   if 5 restarts within 5 cycles then timeout


set httpd port 2812 and
    use address localhost
    allow localhost

check process memcached with pidfile /var/run/memcached/memcached.pid
    start program = "/etc/init.d/memcached start"
    stop program = "/etc/init.d/memcached stop"
    if failed host 127.0.0.1 port 11211 then restart
    if cpu > 70% for 2 cycles then alert
    if cpu > 98% for 5 cycles then restart
    if 2 restarts within 3 cycles then timeout


check process nginx with pidfile /var/run/nginx.pid
  start program = "/etc/init.d/nginx start"
  stop program  = "/etc/init.d/nginx stop"
  if children > 250 then restart
  if failed port 80 then restart  
  if 5 restarts within 5 cycles then timeout


check process postgresql with pidfile /var/run/postgresql/9.1-main.pid
  start program = "/etc/init.d/postgresql start"
  stop program = "/etc/init.d/postgresql stop"
  if failed unixsocket /var/run/postgresql/.s.PGSQL.5432 protocol pgsql then restart
  if failed port 5432 protocol pgsql then restart
  if 5 restarts within 5 cycles then timeout

check process sidekiq
  with pidfile /var/www/application/shared/pids/sidekiq.pid
  start program = "/etc/init.d/sidekiq start"
  stop program = "/etc/init.d/stop stop"

  if mem is greater than 300.0 MB for 1 cycles then restart       # eating up memory?
  if cpu is greater than 50% for 2 cycles then alert                  # send an email to admin
  if cpu is greater than 80% for 3 cycles then restart                # hung process?

  group sidekiq


resque
resque-scheduler

check process unicorn with pidfile /srv/www/amber/shared/tmp/unicorn.pid
  start program "/etc/init.d/unicorn start"
  stop program "/etc/init.d/unicorn stop"
  if 5 restarts within 5 cycles then timeout