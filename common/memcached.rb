# /etc/init.d/memcached start 
# service memcached start

package "memcached" do
  action :install
  options "-y"
end

service "memcached" do
  action :start
end

# adding supervisord

# adding monit 
# template "/etc/monit.d/memcached" do
#   source "monit/memcached.erb"
# end
