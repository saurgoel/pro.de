# Installing ruby from source
task :'ruby:install' do
  comment %{Installing ruby}
  command %{sudo yum install -y ruby}
  command %{sudo yum install -y gcc g++ make automake autoconf curl-devel openssl-devel zlib-devel httpd-devel apr-devel apr-util-devel sqlite-devel}
  command %{sudo yum install -y ruby-rdoc ruby-devel}
end

# Installing ruby gems from source
task :'rubygems:install' do
  comment %{Installing rubygems}
  command %{sudo yum install -y rubygems}
end

# Installing ruby from source
# user "root"
# code <<-EOH
#   yum install -y gcc automake gdbm-devel libffi-devel libyaml-devel openssl-devel ncurses-devel readline-devel zlib-devel
#   wget http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.1.tar.bz2
#   tar -xjvf ruby-2.1.1.tar.bz2
#   cd ruby-2.1.1
#   ./configure --prefix=/opt/rubies/ruby-2.1.1
#   make
#   sudo make install
#   cd ..
#   rm -rf ruby-2.1.1.tar.bz2 ruby-2.1.1
# EOH

# installing ruby gems from source
# user "root"
# code <<-EOH
#   wget http://production.cf.rubygems.org/rubygems/rubygems-1.8.24.tgz
#   tar xvzf rubygems-1.8.24.tgz
#   cd rubygems-1.8.24
#   ruby setup.rb
#   cd ..
#   rm -rf rubygems-1.8.24.tgz rubygems-1.8.24
# EOH
