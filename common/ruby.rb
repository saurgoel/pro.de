<!-- Execute this finally -->
chruby 2.1.1

# -------------------------------------
# RECIPE TO INSTALL REDIS IN PRODUCTION
# * Set supervisor after this installation
# * Requires EPEL packages to be enabled.
# execute "yum localinstall -y http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm"
# * Redis runs in the backgroud as a daemon (/etc/init.d/)
# * Accessible on port 6379 (RESP Protocol)
# -------------------------------------

bash "install ruby from source" do
  user "root"
  code <<-EOH
    yum install -y gcc automake gdbm-devel libffi-devel libyaml-devel openssl-devel ncurses-devel readline-devel zlib-devel
    wget http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.1.tar.bz2
    tar -xjvf ruby-2.1.1.tar.bz2
    cd ruby-2.1.1
    ./configure --prefix=/opt/rubies/ruby-2.1.1
    make
    sudo make install
    cd ..
    rm -rf ruby-2.1.1.tar.bz2 ruby-2.1.1
  EOH
end

bash "installing ruby gems from source" do
  user "root"
  code <<-EOH
    wget http://production.cf.rubygems.org/rubygems/rubygems-1.8.24.tgz
    tar xvzf rubygems-1.8.24.tgz
    cd rubygems-1.8.24
    ruby setup.rb
    cd ..
    rm -rf rubygems-1.8.24.tgz rubygems-1.8.24
  EOH
end

bash "installing chruby from source" do
  user "root"
  code <<-EOH
    wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
    tar -xzvf chruby-0.3.9.tar.gz
    cd chruby-0.3.9/
    sudo make install
    ./scripts/setup.sh
    cd ..
    rm -rf chruby-0.3.9.tar.gz chruby-0.3.9
  EOH
end