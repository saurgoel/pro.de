
# supervisord
# include_recipe 'java'
# include_recipe 'elasticsearch::default'
# production settings of elasticsearch
# set up a cluster

# Installing java
cd /opt/
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.tar.gz"
tar xzf jdk-8u60-linux-x64.tar.gz

# cd /opt/jdk1.8.0_60/
# alternatives --install /usr/bin/java java /opt/jdk1.8.0_60/bin/java 2
# alternatives --config java

# After extracting archive file use alternatives command to install it. alternatives command is available in chkconfig package.

# alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_60/bin/jar 2
# alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_60/bin/javac 2
# alternatives --set jar /opt/jdk1.8.0_60/bin/jar
# alternatives --set javac /opt/jdk1.8.0_60/bin/javac 

# Setup JAVA_HOME Variable
export JAVA_HOME=/opt/jdk1.8.0_60
# Setup JRE_HOME Variable
export JRE_HOME=/opt/jdk1.8.0_60/jre
# Setup PATH Variable
export PATH=$PATH:/opt/jdk1.8.0_60/bin:/opt/jdk1.8.0_60/jre/bin


# Installing elasticsearch
wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.0.tar.gz
tar xzf elasticsearch-1.7.0.tar.gz
mv elasticsearch-1.7.0 /usr/share/elasticsearch
cd /usr/share/elasticsearch

# Running elasticsearch normally
/usr/share/elasticsearch/bin/elasticsearch start

# Runnin elasticsearch in brackogrun. Just provide a -d flag
/bin/elasticsearch -d



# http://tecadmin.net/install-elasticsearch-on-linux/
# single node vs multi node cluster

# 
# ./bin/elasticsearch &

# ====== PERMISSIONS
# Open port 22 for ssh and 9200 for elasticsearch 
