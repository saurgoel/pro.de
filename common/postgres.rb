# Custom username and password (pass that )
namespace :postgres do
  desc "Installing Postgres Client"
  task :install_client do
    comment %{Installing postgres client}
    command %[sudo yum install -y postgresql-devel]  
    # Geos library headers required for suppoer of postgis Both geos and proj
    command %[sudo yum install -y geos-devel]  
    command %[sudo yum install -y proj-devel]  
  end
  
  desc "Installing Postgres Server"
  task :install do
    comment %{Installing postgres server}
    # sed -i '/\[base\]/,/gpgkey=/{/gpgkey=/s/$/\'$'\n''exclude = postgres*/;}' /etc/yum.repos.d/CentOS-Base.repo
    # sed -i '/\[updates\]/,/gpgkey=/{/gpgkey=/s/$/\'$'\n''exclude = postgres*/;}' /etc/yum.repos.d/CentOS-Base.repo
    # yum localinstall -y http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
    # yum install -y postgresql93-server
    # yum localinstall -y http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
    # yum install -y postgis2_93
    # POSTGRES_CONF = /var/lib/pgsql/9.3/data/postgresql.conf
    # sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" $POSTGRES_CONF
    # PG_HBA_CONF = /var/lib/pgsql/9.3/data/pg_hba.conf

    # service postgresql-9.3 initdb
    # service postgresql-9.3 start

    # echo "Please enter password for user amber_su"
    # su - postgres -c "createuser -s --replication -P amber_su"
    # echo "Please enter password for user amber"
    # su - postgres -c "createuser -s --replication -P amber"

    #create DB with role amber
    # read -p "Please enter the database name:" DB
    # su - postgres -c "createdb -O amber $DB && psql $DB --command \
    # 'create schema postgis; create extension postgis WITH SCHEMA postgis;\
    # grant ALL ON SCHEMA postgis TO amber;'"
  end

  task :test do
  end

  task :start do
    comment %{Starting Postgres}
  end

  task :stop do
    comment %{Stopping Postgres}
  end
end

# Script for DB relplication
# Set up realtime replication database
# So as if one goes down then this can be made up
# Another script to create backups of the replica database at regular intervals of time
# Replication user is created seperately. The replica server will login using these credentials into the main database server.
# Perform hot standbys
# replica.sh
# #!/bin/bash

# PG_DATA=/var/lib/pgsql/9.3/data/

#sed -i '/\[base\]/,/gpgkey=/{/gpgkey=/s/$/\'$'\n''exclude = postgres*/;}' /etc/yum.repos.d/CentOS-Base.repo
#sed -i '/\[updates\]/,/gpgkey=/{/gpgkey=/s/$/\'$'\n''exclude = postgres*/;}' /etc/yum.repos.d/CentOS-Base.repo
#yum localinstall -y http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
#yum install -y postgresql93-server
#yum localinstall -y http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
#yum install -y postgis2_93
#service postgresql-9.3 initdb

# rm -rf /var/lib/pgsql/9.3/data/
# read -p "enter primary server IP:" primary_ip
# su - postgres -s /bin/bash --command="/usr/bin/pg_basebackup -h $primary_ip -D /var/lib/pgsql/9.3/data -P -U replication --xlog-method=stream"
#
# #replication server specific settings
# sed -i "/listen_addresses/d" $PG_DATA/conf.d/amber.conf
# read -p "Enter server IP(bind address):" ip
# echo -e "listen_addresses = '$ip, localhost'" >> $PG_DATA/conf.d/amber.conf
#
#
# #replication specific settings
# echo -e "hot_standby = on" >> $PG_DATA/conf.d/amber.conf
# echo -e "standby_mode = 'on'
# primary_conninfo = 'host=$primary_ip port=5432 user=replication password=amber'
# trigger_file = '/tmp/postgresql.trigger.5432'" >> $PG_DATA/recovery.conf
