#!/bin/bash

SPARK_HOME="/opt/spark-2.3.0-bin-hadoop2.7"

echo Using SPARK_HOME=$SPARK_HOME

. "${SPARK_HOME}/sbin/spark-config.sh"

. "${SPARK_HOME}/bin/load-spark-env.sh"

export JAVA_HOME="/opt/jdk1.8.0_181/"                                                                                                                               
export PATH="$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:/opt/hadoop/bin/:/opt/hadoop/sbin/"
#export HADOOP_HOME="/opt/hadoop"
#export PATH="$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$SPARK_HOME/bin:$SPARK_HOME/sbin"
export PATH="$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin"
#export HADOOP_CONF_DIR="$HADOOP_HOME/etc/hadoop"
export HADOOP_CONF_DIR="$SPARK_HOME/conf"
#export HADOOP_PREFIX="$HADOOP_HOME"
#export HADOOP_SBIN_DIR="$HADOOP_HOME/sbin"
#export HADOOP_SBIN_DIR="$HADOOP_HOME/bin"
#export HADOOP_CLASSPATH="$HADOOP_HOME/share/hadoop/common/"
export JAVA_CLASSPATH="$JAVA_HOME/jre/lib/"
export JAVA_OPTS="-Dsun.security.krb5.debug=true -XX:MetaspaceSize=128M -XX:MaxMetaspaceSize=256M"
export CONDA_DIR="/opt/conda"

cp /opt/hadoop/share/hadoop/common/hadoop-common-2.7.5.jar /opt/spark-2.3.0-bin-hadoop2.7/jars/

mv $SPARK_HOME/conf/core-site.xml.datalake $SPARK_HOME/conf/core-site.xml

if [ "$MAX_CLIENTS" != "" ]; then
	sed "s/def initialize(self, max_clients=10, defaults=None):/def initialize(self, max_clients=$MAX_CLIENTS, defaults=None):/" $CONDA_DIR/envs/python3/lib/python3.5/site-packages/tornado/curl_httpclient.py >> $CONDA_DIR/envs/python3/lib/python3.5/site-packages/tornado/curl_httpclient.py.tmp  && \
	mv $CONDA_DIR/envs/python3/lib/python3.5/site-packages/tornado/curl_httpclient.py.tmp $CONDA_DIR/envs/python3/lib/python3.5/site-packages/tornado/curl_httpclient.py
	
	sed "s/def initialize(self, max_clients=10,/def initialize(self, max_clients=$MAX_CLIENTS,/" $CONDA_DIR/envs/python3/lib/python3.5/site-packages/tornado/simple_httpclient.py >> $CONDA_DIR/envs/python3/lib/python3.5/site-packages/tornado/simple_httpclient.py.tmp && \
	mv $CONDA_DIR/envs/python3/lib/python3.5/site-packages/tornado/simple_httpclient.py.tmp $CONDA_DIR/envs/python3/lib/python3.5/site-packages/tornado/simple_httpclient.py
	
	sed "s/def initialize(self, max_clients=10, defaults=None):/def initialize(self, max_clients=$MAX_CLIENTS, defaults=None):/" $CONDA_DIR/lib/python2.7/site-packages/tornado/curl_httpclient.py >> $CONDA_DIR/lib/python2.7/site-packages/tornado/curl_httpclient.py.tmp && \
	mv $CONDA_DIR/lib/python2.7/site-packages/tornado/curl_httpclient.py.tmp $CONDA_DIR/lib/python2.7/site-packages/tornado/curl_httpclient.py
	
	sed "s/def initialize(self, max_clients=10,/def initialize(self, max_clients=$MAX_CLIENTS,/" $CONDA_DIR/lib/python2.7/site-packages/tornado/simple_httpclient.py >> $CONDA_DIR/lib/python2.7/site-packages/tornado/simple_httpclient.py.tmp && \
	mv $CONDA_DIR/lib/python2.7/site-packages/tornado/simple_httpclient.py.tmp $CONDA_DIR/lib/python2.7/site-packages/tornado/simple_httpclient.py
	
	sed "s/def initialize(self, max_clients=10, defaults=None):/def initialize(self, max_clients=$MAX_CLIENTS, defaults=None):/" $CONDA_DIR/pkgs/tornado-5.1-py27h14c3975_0/lib/python2.7/site-packages/tornado/curl_httpclient.py >> $CONDA_DIR/pkgs/tornado-5.1-py27h14c3975_0/lib/python2.7/site-packages/tornado/curl_httpclient.py.tmp && \ 
	mv $CONDA_DIR/pkgs/tornado-5.1-py27h14c3975_0/lib/python2.7/site-packages/tornado/curl_httpclient.py.tmp $CONDA_DIR/pkgs/tornado-5.1-py27h14c3975_0/lib/python2.7/site-packages/tornado/curl_httpclient.py
	
	sed "s/def initialize(self, max_clients=10,/def initialize(self, max_clients=$MAX_CLIENTS,/" $CONDA_DIR/pkgs/tornado-5.1-py27h14c3975_0/lib/python2.7/site-packages/tornado/simple_httpclient.py >> $CONDA_DIR/pkgs/tornado-5.1-py27h14c3975_0/lib/python2.7/site-packages/tornado/simple_httpclient.py.tmp && \
 	mv $CONDA_DIR/pkgs/tornado-5.1-py27h14c3975_0/lib/python2.7/site-packages/tornado/simple_httpclient.py.tmp $CONDA_DIR/pkgs/tornado-5.1-py27h14c3975_0/lib/python2.7/site-packages/tornado/simple_httpclient.py
	
	sed "s/def initialize(self, max_clients=10, defaults=None):/def initialize(self, max_clients=$MAX_CLIENTS, defaults=None):/" $CONDA_DIR/pkgs/tornado-5.1-py35h14c3975_0/lib/python3.5/site-packages/tornado/curl_httpclient.py >> $CONDA_DIR/pkgs/tornado-5.1-py35h14c3975_0/lib/python3.5/site-packages/tornado/curl_httpclient.py.tmp && \
	mv $CONDA_DIR/pkgs/tornado-5.1-py35h14c3975_0/lib/python3.5/site-packages/tornado/curl_httpclient.py.tmp $CONDA_DIR/pkgs/tornado-5.1-py35h14c3975_0/lib/python3.5/site-packages/tornado/curl_httpclient.py
	
	sed "s/def initialize(self, max_clients=10,/def initialize(self, max_clients=$MAX_CLIENTS,/" $CONDA_DIR/pkgs/tornado-5.1-py35h14c3975_0/lib/python3.5/site-packages/tornado/simple_httpclient.py >> $CONDA_DIR/pkgs/tornado-5.1-py35h14c3975_0/lib/python3.5/site-packages/tornado/simple_httpclient.py.tmp && \
	mv $CONDA_DIR/pkgs/tornado-5.1-py35h14c3975_0/lib/python3.5/site-packages/tornado/simple_httpclient.py.tmp $CONDA_DIR/pkgs/tornado-5.1-py35h14c3975_0/lib/python3.5/site-packages/tornado/simple_httpclient.py
fi

if [ "$DEV" == "integration" ]; then 
	cp /etc/krb5.conf.integration /etc/krb5.conf
	cp /etc/krb5.conf /opt/datalake-1.5-SNAPSHOT/conf/
	mv $SPARK_HOME/conf/core-site.xml.datalake.integration $SPARK_HOME/conf/core-site.xml			
fi


if [ "$ENCRYPTION" != "" ]; then
	sed "s/ENCRYPTION/$ENCRYPTION/" $SPARK_HOME/conf/core-site.xml >> $SPARK_HOME/conf/core-site.xml.tmp && \
	mv /$SPARK_HOME/conf/core-site.xml.tmp $SPARK_HOME/conf/core-site.xml
	
	sed "s/ENC_KEY_PATH/${ENC_KEY_PATH}/" $SPARK_HOME/conf/core-site.xml >> $SPARK_HOME/conf/core-site.xml.tmp && \
	mv $SPARK_HOME/conf/core-site.xml.tmp $SPARK_HOME/conf/core-site.xml
	
	# Download Bigstep Data Lake Client Libraries
	# there is a DLEncryption already initialized error that has to be treated before enabling encryption on Spark clusters. For testing and development purposes I commented that section
	if [ "$ENCRYPTION" == "true" ]; then 
		wget https://github.com/bigstepinc/datalake-client-libraries/releases/download/1.5.2/datalake-client-libraries-1.5-SNAPSHOT.jar -P $SPARK_HOME/jars/
		
		if [ "$CIPHER_CLASS" != "" ]; then
			echo "spark.authenticate.encryption.aes.cipher.class=$CIPHER_CLASS" >> $SPARK_HOME/conf/spark-defaults.conf
		fi
		if [ "$CIPHER_KEYSIZE" != "" ]; then 
			echo "spark.authenticate.encryption.aes.cipher.keySize=$CIPHER_KEYSIZE" >> $SPARK_HOME/conf/spark-defaults.conf
		fi
		if [ "$AUTH_ENC" != "" ]; then
			echo "spark.authenticate.encryption.aes.enabled=$AUTH_ENC" >> $SPARK_HOME/conf/spark-defaults.conf
		fi
	else
		wget https://github.com/bigstepinc/datalake-client-libraries/releases/download/untagged-9758317a72f268684537/datalake-client-libraries-1.5-SNAPSHOT.jar -P $SPARK_HOME/jars/
	fi
fi

if [ "$SPARK_WAREHOUSE_DIR" != "" ]; then
	echo "spark.sql.warehouse.dir=$SPARK_WAREHOUSE_DIR" >> $SPARK_HOME/conf/spark-defaults.conf
fi

if [ "$DATALAKE_USER" != "" ]; then
	sed "s/DATALAKE_USER/$DATALAKE_USER/" $SPARK_HOME/conf/core-site.xml >> $SPARK_HOME/conf/core-site.xml.tmp && \
	mv $SPARK_HOME/conf/core-site.xml.tmp $SPARK_HOME/conf/core-site.xml
fi

if [ "$DATALAKE_DOMAIN" != "" ]; then
	sed "s/DATALAKE_DOMAIN/$DATALAKE_DOMAIN/" $SPARK_HOME/conf/core-site.xml >> $SPARK_HOME/conf/core-site.xml.tmp && \
	mv $SPARK_HOME/conf/core-site.xml.tmp $SPARK_HOME/conf/core-site.xml
fi

if [ "$KEYTAB_PATH" != "" ]; then
	sed "s/KEYTAB_PATH/${KEYTAB_PATH}/" $SPARK_HOME/conf/core-site.xml >> $SPARK_HOME/conf/core-site.xml.tmp && \
	mv $SPARK_HOME/conf/core-site.xml.tmp $SPARK_HOME/conf/core-site.xml
fi

if [ "$DATALAKE_NODE" != "" ]; then
	echo "spark.sql.warehouse.dir=dl://DATALAKE_NODE:14000/data_lake/USER_HOME_DIR" >> $SPARK_HOME/conf/spark-defaults.conf

	sed "s/DATALAKE_NODE/${DATALAKE_NODE}/" $SPARK_HOME/conf/core-site.xml >> $SPARK_HOME/conf/core-site.xml.tmp && \
	mv $SPARK_HOME/conf/core-site.xml.tmp $SPARK_HOME/conf/core-site.xml
	
	sed "s/DATALAKE_NODE/${DATALAKE_NODE}/" $SPARK_HOME/conf/spark-defaults.conf >> $SPARK_HOME/conf/spark-defaults.conf.tmp && \
	mv $SPARK_HOME/conf/spark-defaults.conf.tmp $SPARK_HOME/conf/spark-defaults.conf
fi

if [ "$USER_HOME_DIR" != "" ]; then
	mkdir -p $USER_HOME_DIR
	sed "s/USER_HOME_DIR/$USER_HOME_DIR/" $SPARK_HOME/conf/core-site.xml >> $SPARK_HOME/conf/core-site.xml.tmp && \
	mv $SPARK_HOME/conf/core-site.xml.tmp $SPARK_HOME/conf/core-site.xml
	
	sed "s/USER_HOME_DIR/$USER_HOME_DIR/" $SPARK_HOME/conf/spark-defaults.conf >> $SPARK_HOME/conf/spark-defaults.conf.tmp && \
	mv /$SPARK_HOME/conf/spark-defaults.conf.tmp $SPARK_HOME/conf/spark-defaults.conf
fi

if [ "$SPARK_MASTER_PORT" == "" ]; then
  SPARK_MASTER_PORT=7077
fi
if [ "$SPARK_MASTER_IP" == "" ]; then
  SPARK_MASTER_IP="0.0.0.0"
fi
if [ "$SPARK_MASTER_WEBUI_PORT" == "" ]; then
  SPARK_MASTER_WEBUI_PORT=8080
fi
if [ "$SPARK_WORKER_WEBUI_PORT" == "" ]; then
  SPARK_WORKER_WEBUI_PORT=8081
fi
if [ "$SPARK_UI_PORT" == "" ]; then
  SPARK_UI_PORT=4040
fi
if [ "$SPARK_WORKER_PORT" == "" ]; then
  SPARK_WORKER_PORT=8581
fi
if [ "$CORES" == "" ]; then
  CORES=1
fi
if [ "$MEM" == "" ]; then
  MEM=1g
fi
if [ "$SPARK_MASTER_HOSTNAME" == "" ]; then
  SPARK_MASTER_HOSTNAME=`hostname -f`
fi
# Setting defaults for spark and Hive parameters -> RPC error
if [ "$SPARK_NETWORK_TIMEOUT" == "" ]; then
  SPARK_NETWORK_TIMEOUT=120
fi
if [ "$SPARK_RPC_TIMEOUT" == "" ]; then
  SPARK_RPC_TIMEOUT=120
fi
if [ "$SPARK_RPC_NUM_RETRIES" == "" ]; then
  SPARK_RPC_NUM_RETRIES=3
fi
if [ "$DYNAMIC_PARTITION_VALUE" == "" ]; then
  DYNAMIC_PARTITION_VALUE=`true`
fi
if [ "$DYNAMIC_PARTITION_MODE" == "" ]; then
  DYNAMIC_PARTITION_MODE=`nonstrict`
fi
if [ "$NR_MAX_DYNAMIC_PARTITIONS" == "" ]; then
  NR_MAX_DYNAMIC_PARTITIONS=1000
fi
if [ "$MAX_DYNAMIC_PARTITIONS_PER_NODE" == "" ]; then
  MAX_DYNAMIC_PARTITIONS_PER_NODE=100
fi
if [ "$NEW_SIZE_JVM" == "" ]; then
	NEW_SIZE_JVM=1024
fi

cp /root/google-collections-1.0.jar $SPARK_HOME/jars/
cp /bigstep/kerberos/user.keytab $KEYTAB_PATH_URI

if [ "$NOTEBOOK_DIR" != "" ]; then

	mkdir $NOTEBOOK_DIR
	mkdir $NOTEBOOK_DIR/$SPARK_PUBLIC_DNS
	mkdir $NOTEBOOK_DIR/$SPARK_PUBLIC_DNS/logs
	mkdir $NOTEBOOK_DIR/$SPARK_PUBLIC_DNS/work
	mkdir $NOTEBOOK_DIR/$SPARK_PUBLIC_DNS/local
	
	cp $SPARK_HOME/conf/spark-env.sh.template $SPARK_HOME/conf/spark-env.sh
	echo "SPARK_WORKER_DIR=$NOTEBOOK_DIR/$SPARK_PUBLIC_DNS/work" >> $SPARK_HOME/conf/spark-env.sh
	
	sed "s/LOG_DIR/${ESCAPED_NOTEBOOK_DIR}\/$SPARK_PUBLIC_DNS\/logs/" $SPARK_HOME/conf/spark-defaults.conf >> $SPARK_HOME/conf/spark-defaults.conf.tmp && \
	mv $SPARK_HOME/conf/spark-defaults.conf.tmp $SPARK_HOME/conf/spark-defaults.conf

	sed "s/LOCAL_DIR/${ESCAPED_NOTEBOOK_DIR}\/$SPARK_PUBLIC_DNS\/local/" $SPARK_HOME/conf/spark-defaults.conf >> $SPARK_HOME/conf/spark-defaults.conf.tmp && \
	mv $SPARK_HOME/conf/spark-defaults.conf.tmp $SPARK_HOME/conf/spark-defaults.conf
fi

if [ "$PERSISTENT_NB_DIR" != "" ]; then

	mkdir $PERSISTENT_NB_DIR/notebooks
	cp /user/notebooks/* $PERSISTENT_NB_DIR/notebooks/
	
	sed "s/#c.NotebookApp.notebook_dir = u.*/c.NotebookApp.notebook_dir = u\'$ESCAPED_PERSISTENT_NB_DIR\/notebooks\'/" /root/.jupyter/jupyter_notebook_config.py >> /root/.jupyter/jupyter_notebook_config.py.tmp
	mv /root/.jupyter/jupyter_notebook_config.py.tmp /root/.jupyter/jupyter_notebook_config.py
	
fi

if [ "$CLEANUP_ENABLED" != "" ]; then
	sed "s/CLEANUP_ENABLED/$CLEANUP_ENABLED/" $SPARK_HOME/conf/spark-defaults.conf >> $SPARK_HOME/conf/spark-defaults.conf.tmp && \
	mv $SPARK_HOME/conf/spark-defaults.conf.tmp $SPARK_HOME/conf/spark-defaults.conf
fi

if [ "$CLEANUP_INTERVAL" != "" ]; then
	sed "s/CLEANUP_INTERVAL/$CLEANUP_INTERVAL/" $SPARK_HOME/conf/spark-defaults.conf >> $SPARK_HOME/conf/spark-defaults.conf.tmp && \
	mv $SPARK_HOME/conf/spark-defaults.conf.tmp $SPARK_HOME/conf/spark-defaults.conf
fi

if [ "$CLEANUP_APPDATA" != "" ]; then
	sed "s/CLEANUP_APPDATA/$CLEANUP_APPDATA/" $SPARK_HOME/conf/spark-defaults.conf >> $SPARK_HOME/conf/spark-defaults.conf.tmp && \
	mv $SPARK_HOME/conf/spark-defaults.conf.tmp $SPARK_HOME/conf/spark-defaults.conf
fi

sed "s/HOSTNAME_MASTER/$SPARK_MASTER_HOSTNAME/" $SPARK_HOME/conf/spark-defaults.conf >> $SPARK_HOME/conf/spark-defaults.conf.tmp && \
mv $SPARK_HOME/conf/spark-defaults.conf.tmp $SPARK_HOME/conf/spark-defaults.conf

sed "s/NEW_SIZE_JVM/$NEW_SIZE_JVM/" $SPARK_HOME/conf/spark-defaults.conf >> $SPARK_HOME/conf/spark-defaults.conf.tmp && \
mv $SPARK_HOME/conf/spark-defaults.conf.tmp $SPARK_HOME/conf/spark-defaults.conf

sed "s/SPARK_UI_PORT/$SPARK_UI_PORT/" $SPARK_HOME/conf/spark-defaults.conf >> $SPARK_HOME/conf/spark-defaults.conf.tmp && \
mv $SPARK_HOME/conf/spark-defaults.conf.tmp $SPARK_HOME/conf/spark-defaults.conf

#Disable AnacondaCloud extension
#sed "s/\"nb_anacondacloud\": true/\"nb_anacondacloud\": false/" /root/.jupyter/jupyter_notebook_config.py >> /root/.jupyter/jupyter_notebook_config.py.tmp 
#mv /root/.jupyter/jupyter_notebook_config.py.tmp /root/.jupyter/jupyter_notebook_config.py

#sed "s/\"nb_anacondacloud\": true/\"nb_anacondacloud\": false/" /opt/conda/etc/jupyter/jupyter_notebook_config.json >> /opt/conda/etc/jupyter/jupyter_notebook_config.json.tmp
#mv /opt/conda/etc/jupyter/jupyter_notebook_config.json.tmp /opt/conda/etc/jupyter/jupyter_notebook_config.json

#sed "s/\"nb_anacondacloud\": true/\"nb_anacondacloud\": false/" /opt/conda/pkgs/_nb_ext_conf-0.3.0-py27_0/etc/jupyter/jupyter_notebook_config.json >> /opt/conda/pkgs/_nb_ext_conf-0.3.0-py27_0/etc/jupyter/jupyter_notebook_config.json.tmp 
#mv /opt/conda/pkgs/_nb_ext_conf-0.3.0-py27_0/etc/jupyter/jupyter_notebook_config.json.tmp /opt/conda/pkgs/_nb_ext_conf-0.3.0-py27_0/etc/jupyter/jupyter_notebook_config.json

#sed "s/\"nb_anacondacloud\": true/\"nb_anacondacloud\": false/" /opt/conda/pkgs/_nb_ext_conf-0.3.0-py35_0/etc/jupyter/jupyter_notebook_config.json >> /opt/conda/pkgs/_nb_ext_conf-0.3.0-py35_0/etc/jupyter/jupyter_notebook_config.json.tmp
#mv /opt/conda/pkgs/_nb_ext_conf-0.3.0-py35_0/etc/jupyter/jupyter_notebook_config.json.tmp /opt/conda/pkgs/_nb_ext_conf-0.3.0-py35_0/etc/jupyter/jupyter_notebook_config.json

#sed "s/\"nb_anacondacloud\/main\": true/\"nb_anacondacloud\/main\": false/" /opt/conda/envs/python3/etc/jupyter/nbconfig/notebook.json >> /opt/conda/envs/python3/etc/jupyter/nbconfig/notebook.json.tmp
#mv /opt/conda/envs/python3/etc/jupyter/nbconfig/notebook.json.tmp /opt/conda/envs/python3/etc/jupyter/nbconfig/notebook.json

#sed "s/\"nb_anacondacloud\/main\": true/\"nb_anacondacloud\/main\": false/" /opt/conda/etc/jupyter/nbconfig/notebook.json >> /opt/conda/etc/jupyter/nbconfig/notebook.json.tmp
#mv /opt/conda/etc/jupyter/nbconfig/notebook.json.tmp /opt/conda/etc/jupyter/nbconfig/notebook.json

if [ "$MODE" == "master" ]; then 
	# Change the Home Icon 
	sed "s/<i class=\"fa fa-home\"><\/i>/\/user/" /opt/conda/envs/python3/lib/python3.5/site-packages/notebook/templates/tree.html >> /opt/conda/envs/python3/lib/python3.5/site-packages/notebook/templates/tree.html.tmp
	mv /opt/conda/envs/python3/lib/python3.5/site-packages/notebook/templates/tree.html.tmp /opt/conda/envs/python3/lib/python3.5/site-packages/notebook/templates/tree.html

	sed "s/<i class=\"fa fa-home\"><\/i>/\/user/" /opt/conda/lib/python2.7/site-packages/notebook/templates/tree.html >> /opt/conda/lib/python2.7/site-packages/notebook/templates/tree.html.tmp
	mv /opt/conda/lib/python2.7/site-packages/notebook/templates/tree.html.tmp /opt/conda/lib/python2.7/site-packages/notebook/templates/tree.html

	#sed "s/<i class=\"fa fa-home\"><\/i>/\/user/" /opt/conda/pkgs/notebook-4.2.3-py27_0/lib/python2.7/site-packages/notebook/templates/tree.html >> /opt/conda/pkgs/notebook-4.2.3-py27_0/lib/python2.7/site-packages/notebook/templates/tree.html.tmp
	#mv /opt/conda/pkgs/notebook-4.2.3-py27_0/lib/python2.7/site-packages/notebook/templates/tree.html.tmp /opt/conda/pkgs/notebook-4.2.3-py27_0/lib/python2.7/site-packages/notebook/templates/tree.html

	#sed "s/<i class=\"fa fa-home\"><\/i>/\/user/" /opt/conda/pkgs/notebook-4.2.3-py35_0/lib/python3.5/site-packages/notebook/templates/tree.html >> /opt/conda/pkgs/notebook-4.2.3-py35_0/lib/python3.5/site-packages/notebook/templates/tree.html.tmp
	#mv /opt/conda/pkgs/notebook-4.2.3-py35_0/lib/python3.5/site-packages/notebook/templates/tree.html.tmp /opt/conda/pkgs/notebook-4.2.3-py35_0/lib/python3.5/site-packages/notebook/templates/tree.html    
fi

if [ "$SPARK_MASTER_URL" == "" ]; then 
	SPARK_MASTER_URL="spark://$SPARK_MASTER_HOSTNAME:$SPARK_MASTER_PORT"
	echo "Using SPARK_MASTER_URL=$SPARK_MASTER_URL"
fi

export SPARK_OPTS="--driver-java-options=-$JAVA_DRIVER_OPTS --driver-java-options=-XX:MetaspaceSize=128M --driver-java-options=-XX:MaxMetaspaceSize=256M --driver-java-options=-Dlog4j.logLevel=info --master $SPARK_MASTER_URL --files $SPARK_HOME/conf/hive-site.xml"

if [ "$POSTGRES_HOSTNAME" != "" ]; then
	sed "s/POSTGRES_HOSTNAME/$POSTGRES_HOSTNAME/" $SPARK_HOME/conf/hive-site.xml >> $SPARK_HOME/conf/hive-site.xml.tmp && \
	mv $SPARK_HOME/conf/hive-site.xml.tmp $SPARK_HOME/conf/hive-site.xml
fi

if [ "$POSTGRES_PORT" != "" ]; then
	sed "s/POSTGRES_PORT/$POSTGRES_PORT/" $SPARK_HOME/conf/hive-site.xml >> $SPARK_HOME/conf/hive-site.xml.tmp && \
	mv $SPARK_HOME/conf/hive-site.xml.tmp $SPARK_HOME/conf/hive-site.xml
fi

if [ "$SPARK_POSTGRES_DB" != "" ]; then
	sed "s/SPARK_POSTGRES_DB/$SPARK_POSTGRES_DB/" $SPARK_HOME/conf/hive-site.xml >> $SPARK_HOME/conf/hive-site.xml.tmp && \
	mv $SPARK_HOME/conf/hive-site.xml.tmp $SPARK_HOME/conf/hive-site.xml
fi

if [ "$SPARK_POSTGRES_USER" != "" ]; then
	sed "s/SPARK_POSTGRES_USER/$SPARK_POSTGRES_USER/" $SPARK_HOME/conf/hive-site.xml >> $SPARK_HOME/conf/hive-site.xml.tmp && \
	mv $SPARK_HOME/conf/hive-site.xml.tmp $SPARK_HOME/conf/hive-site.xml
fi

if [ "$DYNAMIC_PARTITION_VALUE" != "" ]; then
	sed "s/DYNAMIC_PARTITION_VALUE/$DYNAMIC_PARTITION_VALUE/" $SPARK_HOME/conf/hive-site.xml >> $SPARK_HOME/conf/hive-site.xml.tmp && \
	mv $SPARK_HOME/conf/hive-site.xml.tmp $SPARK_HOME/conf/hive-site.xml
fi

if [ "$DYNAMIC_PARTITION_MODE" != "" ]; then
	sed "s/DYNAMIC_PARTITION_MODE/$DYNAMIC_PARTITION_MODE/" $SPARK_HOME/conf/hive-site.xml >> $SPARK_HOME/conf/hive-site.xml.tmp && \
	mv $SPARK_HOME/conf/hive-site.xml.tmp $SPARK_HOME/conf/hive-site.xml
fi

if [ "$NR_MAX_DYNAMIC_PARTITIONS" != "" ]; then
	sed "s/NR_MAX_DYNAMIC_PARTITIONS/$NR_MAX_DYNAMIC_PARTITIONS/" $SPARK_HOME/conf/hive-site.xml >> $SPARK_HOME/conf/hive-site.xml.tmp && \
	mv $SPARK_HOME/conf/hive-site.xml.tmp $SPARK_HOME/conf/hive-site.xml
fi

if [ "$MAX_DYNAMIC_PARTITIONS_PER_NODE" != "" ]; then
	sed "s/MAX_DYNAMIC_PARTITIONS_PER_NODE/$MAX_DYNAMIC_PARTITIONS_PER_NODE/" $SPARK_HOME/conf/hive-site.xml >> $SPARK_HOME/conf/hive-site.xml.tmp && \
	mv $SPARK_HOME/conf/hive-site.xml.tmp $SPARK_HOME/conf/hive-site.xml
fi

export SPARK_POSTGRES_PASSWORD=$(cat $SPARK_SECRETS_PATH/SPARK_POSTGRES_PASSWORD)

sed "s/SPARK_POSTGRES_PASSWORD/$SPARK_POSTGRES_PASSWORD/" $SPARK_HOME/conf/hive-site.xml >> $SPARK_HOME/conf/hive-site.xml.tmp && \
mv $SPARK_HOME/conf/hive-site.xml.tmp $SPARK_HOME/conf/hive-site.xml

export POSTGRES_PASSWORD=$(cat $SPARK_SECRETS_PATH/POSTGRES_PASSWORD)
export PGPASSWORD=$POSTGRES_PASSWORD 

psql -h $POSTGRES_HOSTNAME -p $POSTGRES_PORT  -U $POSTGRES_USER -d $POSTGRES_DB -c "CREATE USER $SPARK_POSTGRES_USER WITH PASSWORD '$SPARK_POSTGRES_PASSWORD';"

psql -h $POSTGRES_HOSTNAME -p $POSTGRES_PORT  -U $POSTGRES_USER -d $POSTGRES_DB -c "CREATE DATABASE $SPARK_POSTGRES_DB;"

psql -h $POSTGRES_HOSTNAME -p $POSTGRES_PORT  -U $POSTGRES_USER -d $POSTGRES_DB -c "grant all PRIVILEGES on database $SPARK_POSTGRES_DB to $SPARK_POSTGRES_USER;" 

cd $SPARK_HOME/jars

export PGPASSWORD=$SPARK_POSTGRES_PASSWORD

psql -h $POSTGRES_HOSTNAME -p $POSTGRES_PORT  -U  $SPARK_POSTGRES_USER -d $SPARK_POSTGRES_DB -f /opt/spark-2.3.0-bin-hadoop2.7/jars/hive-schema-1.2.0.postgres.sql


if [ "$MODE" == "master" ]; then 
	export NOTEBOOK_PASSWORD=$(cat $SPARK_SECRETS_PATH/NOTEBOOK_PASSWORD)

	pass=$(python /opt/password.py  $NOTEBOOK_PASSWORD)
	sed "s/#c.NotebookApp.password = u.*/c.NotebookApp.password = u\'$pass\'/" /root/.jupyter/jupyter_notebook_config.py >> /root/.jupyter/jupyter_notebook_config.py.tmp && \
	mv /root/.jupyter/jupyter_notebook_config.py.tmp /root/.jupyter/jupyter_notebook_config.py
fi

if [ "$EX_MEM" != "" ]; then
	sed "s/EX_MEM/$EX_MEM/" $SPARK_HOME/conf/spark-defaults.conf >> $SPARK_HOME/conf/spark-defaults.conf.tmp && \
	mv $SPARK_HOME/conf/spark-defaults.conf.tmp $SPARK_HOME/conf/spark-defaults.conf
fi
if [ "$EX_CORES" != "" ]; then
	sed "s/EX_CORES/$EX_CORES/" $SPARK_HOME/conf/spark-defaults.conf >> $SPARK_HOME/conf/spark-defaults.conf.tmp && \
	mv $SPARK_HOME/conf/spark-defaults.conf.tmp $SPARK_HOME/conf/spark-defaults.conf
fi
if [ "$DRIVER_MEM" != "" ]; then
	sed "s/DRIVER_MEM/$DRIVER_MEM/" $SPARK_HOME/conf/spark-defaults.conf >> $SPARK_HOME/conf/spark-defaults.conf.tmp && \
	mv $SPARK_HOME/conf/spark-defaults.conf.tmp $SPARK_HOME/conf/spark-defaults.conf
fi
if [ "$DRIVER_CORES" != "" ]; then
	sed "s/DRIVER_CORES/$DRIVER_CORES/" $SPARK_HOME/conf/spark-defaults.conf >> $SPARK_HOME/conf/spark-defaults.conf.tmp && \
	mv $SPARK_HOME/conf/spark-defaults.conf.tmp $SPARK_HOME/conf/spark-defaults.conf
fi

if [ "$SPARK_NETWORK_TIMEOUT" != "" ]; then
	sed "s/SPARK_NETWORK_TIMEOUT/$SPARK_NETWORK_TIMEOUT/" $SPARK_HOME/conf/spark-defaults.conf >> $SPARK_HOME/conf/spark-defaults.conf.tmp && \
	mv $SPARK_HOME/conf/spark-defaults.conf.tmp /$SPARK_HOME/conf/spark-defaults.conf
fi
if [ "$SPARK_RPC_TIMEOUT" != "" ]; then
	sed "s/SPARK_RPC_TIMEOUT/$SPARK_RPC_TIMEOUT/" $SPARK_HOME/conf/spark-defaults.conf >> $SPARK_HOME/conf/spark-defaults.conf.tmp && \
	mv $SPARK_HOME/conf/spark-defaults.conf.tmp $SPARK_HOME/conf/spark-defaults.conf
fi

if [ "$SPARK_RPC_NUM_RETRIES" != "" ]; then
	sed "s/SPARK_RPC_NUM_RETRIES/$SPARK_RPC_NUM_RETRIES/" $SPARK_HOME/conf/spark-defaults.conf >> $SPARK_HOME/conf/spark-defaults.conf.tmp && \
	mv $SPARK_HOME/conf/spark-defaults.conf.tmp $SPARK_HOME/conf/spark-defaults.conf
fi

if [ "$SPARK_HEARTBEAT" != "" ]; then
	sed "s/SPARK_HEARTBEAT/$SPARK_HEARTBEAT/" $SPARK_HOME/conf/spark-defaults.conf >> $SPARK_HOME/conf/spark-defaults.conf.tmp && \
	mv $SPARK_HOME/conf/spark-defaults.conf.tmp $SPARK_HOME/conf/spark-defaults.conf
fi

if [ "$MODE" == "master" ]; then 
	if [ "$GIT_REPO_NAME" != "" ]; then
		if [ "$GITHUB_COMMIT_DIR" == "" ]; then 
			export GITHUB_COMMIT_DIR=/opt
		fi
		if [ "$GIT_PARENT_DIR" == "" ]; then 
			export GIT_PARENT_DIR=$PERSISTENT_NB_DIR
		fi
		if [ "$GIT_BRANCH_NAME" == "" ]; then 
			export GIT_BRANCH_NAME=master
		fi
		if [[ "$GIT_USER" != "" && "$GIT_EMAIL" != "" && "$GITHUB_ACCESS_TOKEN" != "" ]]; then 
			if [ "$GIT_USER_UPSTREAM" == "" ]; then 
				export GIT_USER_UPSTREAM=$GIT_USER
			fi
		
			pip install git+https://github.com/sat28/githubcommit.git
			jupyter serverextension enable --py githubcommit
			jupyter nbextension install --py githubcommit
			jupyter nbextension enable githubcommit --py
		
			cd $GITHUB_COMMIT_DIR && git clone https://github.com/sat28/githubcommit
			rm -rf $GITHUB_COMMIT_DIR/githubcommit/env.sh
			mv /opt/env.sh $GITHUB_COMMIT_DIR/githubcommit/
		
			sed "s/GITHUB_COMMIT_DIR=/GITHUB_COMMIT_DIR=$GITUB_COMMIT_DIR/" $GITHUB_COMMIT_DIR/githubcommit/env.sh >> $GITHUB_COMMIT_DIR/githubcommit/env.sh.tmp && \
			mv $GITHUB_COMMIT_DIR/githubcommit/env.sh.tmp $GITHUB_COMMIT_DIR/githubcommit/env.sh
		
			sed "s/GIT_PARENT_DIR=/GIT_PARENT_DIR=$GIT_PARENT_DIR/" $GITHUB_COMMIT_DIR/githubcommit/env.sh >> $GITHUB_COMMIT_DIR/githubcommit/env.sh.tmp && \
			mv $GITHUB_COMMIT_DIR/githubcommit/env.sh.tmp $GITHUB_COMMIT_DIR/githubcommit/env.sh
		
			sed "s/GIT_REPO_NAME=/GIT_REPO_NAME=$GIT_REPO_NAME/" $GITHUB_COMMIT_DIR/githubcommit/env.sh >> $GITHUB_COMMIT_DIR/githubcommit/env.sh.tmp && \
			mv $GITHUB_COMMIT_DIR/githubcommit/env.sh.tmp $GITHUB_COMMIT_DIR/githubcommit/env.sh
		
			sed "s/GIT_BRANCH_NAME=/GIT_BRANCH_NAME=$GIT_BRANCH_NAME/" $GITHUB_COMMIT_DIR/githubcommit/env.sh >> $GITHUB_COMMIT_DIR/githubcommit/env.sh.tmp && \
			mv $GITHUB_COMMIT_DIR/githubcommit/env.sh.tmp $GITHUB_COMMIT_DIR/githubcommit/env.sh
		
			sed "s/GIT_USER=/GIT_USER=$GIT_USER/" $GITHUB_COMMIT_DIR/githubcommit/env.sh >> $GITHUB_COMMIT_DIR/githubcommit/env.sh.tmp && \
			mv $GITHUB_COMMIT_DIR/githubcommit/env.sh.tmp $GITHUB_COMMIT_DIR/githubcommit/env.sh
		
			sed "s/GIT_EMAIL=/GIT_EMAIL=$GIT_EMAIL/" $GITHUB_COMMIT_DIR/githubcommit/env.sh >> $GITHUB_COMMIT_DIR/githubcommit/env.sh.tmp && \
			mv $GITHUB_COMMIT_DIR/githubcommit/env.sh.tmp $GITHUB_COMMIT_DIR/githubcommit/env.sh
		
			sed "s/GITHUB_ACCESS_TOKEN=/GITHUB_ACCESS_TOKEN=$GITHUB_ACCESS_TOKEN/" $GITHUB_COMMIT_DIR/githubcommit/env.sh >> $GITHUB_COMMIT_DIR/githubcommit/env.sh.tmp && \
			mv $GITHUB_COMMIT_DIR/githubcommit/env.sh.tmp $GITHUB_COMMIT_DIR/githubcommit/env.sh
		
			sed "s/GIT_USER_UPSTREAM=/GIT_USER_UPSTREAM=$GIT_USER_UPSTREAM/" $GITHUB_COMMIT_DIR/githubcommit/env.sh >> $GITHUB_COMMIT_DIR/githubcommit/env.sh.tmp && \
			mv $GITHUB_COMMIT_DIR/githubcommit/env.sh.tmp $GITHUB_COMMIT_DIR/githubcommit/env.sh
		
			git config --global user.email "$GIT_EMAIL"
			git config --global user.name "$GIT_USER"
		
			source $GITHUB_COMMIT_DIR/githubcommit/env.sh
			cd $GIT_PARENT_DIR/$GIT_REPO_NAME && \
			git config remote.master.url https://$GIT_USER:$GIT_ACCESS_TOKEN@github.com/$GIT_USER/$GIT_REPO_NAME.git
		
			rm -rf $CONDA_DIR/lib/python2.7/site-packages/githubcommit/handlers.py
			mv /opt/env.sh $CONDA_DIR/lib/python2.7/site-packages/githubcommit/
		fi
	fi
fi

export TERM=xterm

if [ "$MODE" == "master" ]; then 
	#Install sparkmonitor extension
	export SPARKMONITOR_UI_HOST=$SPARK_PUBLIC_DNS
	export SPARKMONITOR_UI_PORT=$SPARK_UI_PORT

	pip install https://github.com/krishnan-r/sparkmonitor/releases/download/v0.0.1/sparkmonitor.tar.gz #Use latest version as in github releases

	jupyter nbextension install sparkmonitor --py --user --symlink 
	jupyter nbextension enable sparkmonitor --py --user            
	jupyter serverextension enable --py --user sparkmonitor

	#ipython profile create && echo "c.InteractiveShellApp.extensions.append('sparkmonitor')" >>  $(ipython profile locate default)/ipython_kernel_config.py
	ipython profile create && echo "c.InteractiveShellApp.extensions.append('sparkmonitor.kernelextension')" >> $(ipython profile locate default)/ipython_kernel_config.py
fi

cp $SPARK_HOME/conf/core-site.xml /opt/datalake-1.5-SNAPSHOT/conf/

export PATH=/opt/datalake-1.5-SNAPSHOT/bin:$PATH
dl -mkdir /tmp
dl -mkdir /tmp/hive 
dl -chmod -R 777 /tmp/hive

if [ "$MODE" == "" ]; then
MODE=$1
fi

CLASSPATH=$SPARK_HOME/jars/

#Configure dl client libraries
export PATH=$PATH:/opt/client-libraries/datalake-client-libraries-untagged-f226f24f5fd0feabde54/src/bin/dl
cp /opt/spark-2.3.0-bin-hadoop2.7/conf/core-site.xml /opt/client-libraries/datalake-client-libraries-untagged-f226f24f5fd0feabde54/src/conf/

if [ "$MODE" == "master" ]; then 
	nohup ${SPARK_HOME}/bin/spark-class "org.apache.spark.deploy.master.Master" -h $SPARK_MASTER_HOSTNAME --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT &
	jupyter notebook --ip=0.0.0.0 --log-level DEBUG --allow-root --NotebookApp.iopub_data_rate_limit=10000000000 --Spark.url="http://$SPARK_PUBLIC_DNS:$SPARK_UI_PORT"

elif [ "$MODE" == "worker" ]; then
	${SPARK_HOME}/bin/spark-class "org.apache.spark.deploy.worker.Worker" --webui-port $SPARK_WORKER_WEBUI_PORT --port $SPARK_WORKER_PORT $SPARK_MASTER_URL -c $CORES -m $MEM -d $NOTEBOOK_DIR/$SPARK_PUBLIC_DNS/work/

elif [ "$MODE" == "thrift" ]; then 
	nohup ${SPARK_HOME}/bin/spark-class "org.apache.spark.deploy.master.Master" -h $SPARK_MASTER_HOSTNAME --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT &
	${SPARK_HOME}/bin/spark-submit --class org.apache.spark.sql.hive.thriftserver.HiveThriftServer2 --name "Thrift JDBC/ODBC Server"  --master $SPARK_MASTER_URL
else
	nohup ${SPARK_HOME}/bin/spark-class "org.apache.spark.deploy.master.Master" -h $SPARK_MASTER_HOSTNAME --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT &
	nohup ${SPARK_HOME}/bin/spark-class "org.apache.spark.deploy.worker.Worker" --webui-port $SPARK_WORKER_WEBUI_PORT --port $SPARK_WORKER_PORT $SPARK_MASTER_URL	-c $CORES -m $MEM -d $NOTEBOOK_DIR/$SPARK_PUBLIC_DNS/work/ &
	jupyter notebook --ip=0.0.0.0 --log-level DEBUG --allow-root --NotebookApp.iopub_data_rate_limit=10000000000 --Spark.url="http://$SPARK_PUBLIC_DNS:$SPARK_UI_PORT"
fi
