#!/bin/bash

SPARK_HOME="/opt/spark-2.1.0-bin-hadoop2.7"

echo Using SPARK_HOME=$SPARK_HOME

. "${SPARK_HOME}/sbin/spark-config.sh"

. "${SPARK_HOME}/bin/load-spark-env.sh"

export JAVA_HOME="/opt/jdk"                                                                                                                               
export PATH="$PATH:/opt/jdk/bin:/opt/jdk/jre/bin:/opt/hadoop/bin/:/opt/hadoop/sbin/"
export HADOOP_HOME="/opt/hadoop"
export PATH="$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$SPARK_HOME/bin:$SPARK_HOME/sbin"
export HADOOP_CONF_DIR="$HADOOP_HOME/etc/hadoop"
export HADOOP_PREFIX="$HADOOP_HOME"
export HADOOP_SBIN_DIR="$HADOOP_HOME/sbin"
export HADOOP_SBIN_DIR="$HADOOP_HOME/bin"
export HADOOP_CLASSPATH="$HADOOP_HOME/share/hadoop/common/"
export JAVA_CLASSPATH="$JAVA_HOME/jre/lib/"
export JAVA_OPTS="-Dsun.security.krb5.debug=true"

rm -rf /opt/hadoop/etc/hadoop/core-site.xml

cp /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.template /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf

if [ "$HDFS_MASTER" != "" ]; then
	sed "s/HOSTNAME/$HDFS_MASTER/" /opt/hadoop/etc/hadoop/core-site.xml.template >> /opt/hadoop/etc/hadoop/core-site.xml
else 
	mv /opt/spark-2.1.0-bin-hadoop2.7/conf/core-site.xml.datalake /opt/hadoop/etc/hadoop/core-site.xml

	
	if [ "$DEV" == "integration" ]; then 
		cp /etc/krb5.conf.integration /etc/krb5.conf
		mv /opt/spark-2.1.0-bin-hadoop2.7/conf/core-site.xml.datalake.integration /opt/hadoop/etc/hadoop/core-site.xml
		
	fi
fi


if [ "$SPARK_WAREHOUSE_DIR" != "" ]; then
	rm /opt/spark-2.1.0-bin-hadoop2.7/conf/core-site.xml
	echo "spark.sql.warehouse.dir=$SPARK_WAREHOUSE_DIR" >> /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf
fi

if [ "$DATALAKE_USER" != "" ]; then
	sed "s/DATALAKE_USER/$DATALAKE_USER/" /opt/hadoop/etc/hadoop/core-site.xml >> /opt/hadoop/etc/hadoop/core-site.xml.tmp && \
	mv /opt/hadoop/etc/hadoop/core-site.xml.tmp /opt/hadoop/etc/hadoop/core-site.xml
	
	cp /opt/hadoop/etc/hadoop/core-site.xml /opt/spark-2.1.0-bin-hadoop2.7/conf/core-site.xml
fi
if [ "$KEYTAB_PATH" != "" ]; then
	sed "s/KEYTAB_PATH/${KEYTAB_PATH}/" /opt/hadoop/etc/hadoop/core-site.xml >> /opt/hadoop/etc/hadoop/core-site.xml.tmp && \
	mv /opt/hadoop/etc/hadoop/core-site.xml.tmp /opt/hadoop/etc/hadoop/core-site.xml
	
	cp /opt/hadoop/etc/hadoop/core-site.xml /opt/spark-2.1.0-bin-hadoop2.7/conf/core-site.xml
fi


if [ "$DATALAKE_NODE" != "" ]; then
	echo "spark.sql.warehouse.dir=dl://DATALAKE_NODE:14000/data_lake/USER_HOME_DIR" >> /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf

	sed "s/DATALAKE_NODE/${DATALAKE_NODE}/" /opt/hadoop/etc/hadoop/core-site.xml >> /opt/hadoop/etc/hadoop/core-site.xml.tmp && \
	mv /opt/hadoop/etc/hadoop/core-site.xml.tmp /opt/hadoop/etc/hadoop/core-site.xml
	
	sed "s/DATALAKE_NODE/${DATALAKE_NODE}/" /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf >> /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp && \
	mv /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf
	
	cp /opt/hadoop/etc/hadoop/core-site.xml /opt/spark-2.1.0-bin-hadoop2.7/conf/core-site.xml

fi

if [ "$USER_HOME_DIR" != "" ]; then
	mkdir -p $USER_HOME_DIR
	sed "s/USER_HOME_DIR/$USER_HOME_DIR/" /opt/hadoop/etc/hadoop/core-site.xml >> /opt/hadoop/etc/hadoop/core-site.xml.tmp && \
	mv /opt/hadoop/etc/hadoop/core-site.xml.tmp /opt/hadoop/etc/hadoop/core-site.xml
	
	sed "s/USER_HOME_DIR/$USER_HOME_DIR/" /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf >> /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp && \
	mv /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf
	
	cp /opt/hadoop/etc/hadoop/core-site.xml /opt/spark-2.1.0-bin-hadoop2.7/conf/core-site.xml
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

if [ "$SPARK_CONTAINER_DIR" != "" ]; then
    
    cp /opt/spark-2.1.0-bin-hadoop2.7/jars/datalake-client-libraries-1.5-SNAPSHOT.jar $HADOOP_HOME/share/hadoop/common/
    cp /root/google-collections-1.0.jar /opt/spark-2.1.0-bin-hadoop2.7/jars/
    
    #sed "s/#c.NotebookApp.certfile = u.*/c.NotebookApp.certfile = u\'$CERTFILE_PATH\'/" /root/.jupyter/jupyter_notebook_config.py >> /root/.jupyter/jupyter_notebook_config.py.tmp && \
	#mv /root/.jupyter/jupyter_notebook_config.py.tmp /root/.jupyter/jupyter_notebook_config.py
    #sed "s/#c.NotebookApp.keyfile = u.*/c.NotebookApp.keyfile = u\'$KEYFILE_PATH\'/" /root/.jupyter/jupyter_notebook_config.py >> /root/.jupyter/jupyter_notebook_config.py.tmp && \
	#mv /root/.jupyter/jupyter_notebook_config.py.tmp /root/.jupyter/jupyter_notebook_config.py
    sed "s/#c.NotebookApp.notebook_dir = u.*/c.NotebookApp.notebook_dir = u\'$NOTEBOOK_DIR\'/" /root/.jupyter/jupyter_notebook_config.py >> /root/.jupyter/jupyter_notebook_config.py.tmp && \
	mv /root/.jupyter/jupyter_notebook_config.py.tmp /root/.jupyter/jupyter_notebook_config.py
    
    cp $SPARK_CONTAINER_DIR/user.keytab $KEYTAB_PATH_URI
fi 

sed "s/SPARK_MASTER_URL/$SPARK_MASTER_URL/" /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf >> /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp && \
mv /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf

sed "s/SPARK_UI_PORT/$SPARK_UI_PORT/" /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf >> /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp && \
mv /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf

#Disable AnacondaCloud extension
sed "s/\"nb_anacondacloud\": true/\"nb_anacondacloud\": false/" /opt/conda/envs/python3/etc/jupyter/jupyter_notebook_config.json >> /opt/conda/envs/python3/etc/jupyter/jupyter_notebook_config.json.tmp 
mv /opt/conda/envs/python3/etc/jupyter/jupyter_notebook_config.json.tmp /opt/conda/envs/python3/etc/jupyter/jupyter_notebook_config.json

sed "s/\"nb_anacondacloud\": true/\"nb_anacondacloud\": false/" /opt/conda/etc/jupyter/jupyter_notebook_config.json >> /opt/conda/etc/jupyter/jupyter_notebook_config.json.tmp
mv /opt/conda/etc/jupyter/jupyter_notebook_config.json.tmp /opt/conda/etc/jupyter/jupyter_notebook_config.json

sed "s/\"nb_anacondacloud\": true/\"nb_anacondacloud\": false/" /opt/conda/pkgs/_nb_ext_conf-0.3.0-py27_0/etc/jupyter/jupyter_notebook_config.json >> /opt/conda/pkgs/_nb_ext_conf-0.3.0-py27_0/etc/jupyter/jupyter_notebook_config.json.tmp 
mv /opt/conda/pkgs/_nb_ext_conf-0.3.0-py27_0/etc/jupyter/jupyter_notebook_config.json.tmp /opt/conda/pkgs/_nb_ext_conf-0.3.0-py27_0/etc/jupyter/jupyter_notebook_config.json

sed "s/\"nb_anacondacloud\": true/\"nb_anacondacloud\": false/" /opt/conda/pkgs/_nb_ext_conf-0.3.0-py35_0/etc/jupyter/jupyter_notebook_config.json >> /opt/conda/pkgs/_nb_ext_conf-0.3.0-py35_0/etc/jupyter/jupyter_notebook_config.json.tmp
mv /opt/conda/pkgs/_nb_ext_conf-0.3.0-py35_0/etc/jupyter/jupyter_notebook_config.json.tmp /opt/conda/pkgs/_nb_ext_conf-0.3.0-py35_0/etc/jupyter/jupyter_notebook_config.json

sed "s/\"nb_anacondacloud\/main\": true/\"nb_anacondacloud\/main\": false/" /opt/conda/envs/python3/etc/jupyter/nbconfig/notebook.json >> /opt/conda/envs/python3/etc/jupyter/nbconfig/notebook.json.tmp
mv /opt/conda/envs/python3/etc/jupyter/nbconfig/notebook.json.tmp /opt/conda/envs/python3/etc/jupyter/nbconfig/notebook.json

sed "s/\"nb_anacondacloud\/main\": true/\"nb_anacondacloud\/main\": false/" /opt/conda/etc/jupyter/nbconfig/notebook.json >> /opt/conda/etc/jupyter/nbconfig/notebook.json.tmp
mv /opt/conda/etc/jupyter/nbconfig/notebook.json.tmp /opt/conda/etc/jupyter/nbconfig/notebook.json

# Change the Home Icon 
sed "s/<i class=\"fa fa-home\"><\/i>/\/user/" /opt/conda/envs/python3/lib/python3.5/site-packages/notebook/templates/tree.html >> /opt/conda/envs/python3/lib/python3.5/site-packages/notebook/templates/tree.html.tmp
mv /opt/conda/envs/python3/lib/python3.5/site-packages/notebook/templates/tree.html.tmp /opt/conda/envs/python3/lib/python3.5/site-packages/notebook/templates/tree.html

sed "s/<i class=\"fa fa-home\"><\/i>/\/user/" /opt/conda/lib/python2.7/site-packages/notebook/templates/tree.html >> /opt/conda/lib/python2.7/site-packages/notebook/templates/tree.html.tmp
mv /opt/conda/lib/python2.7/site-packages/notebook/templates/tree.html.tmp /opt/conda/lib/python2.7/site-packages/notebook/templates/tree.html

sed "s/<i class=\"fa fa-home\"><\/i>/\/user/" /opt/conda/pkgs/notebook-4.2.3-py27_0/lib/python2.7/site-packages/notebook/templates/tree.html >> /opt/conda/pkgs/notebook-4.2.3-py27_0/lib/python2.7/site-packages/notebook/templates/tree.html.tmp
mv /opt/conda/pkgs/notebook-4.2.3-py27_0/lib/python2.7/site-packages/notebook/templates/tree.html.tmp /opt/conda/pkgs/notebook-4.2.3-py27_0/lib/python2.7/site-packages/notebook/templates/tree.html

sed "s/<i class=\"fa fa-home\"><\/i>/\/user/" /opt/conda/pkgs/notebook-4.2.3-py35_0/lib/python3.5/site-packages/notebook/templates/tree.html >> /opt/conda/pkgs/notebook-4.2.3-py35_0/lib/python3.5/site-packages/notebook/templates/tree.html.tmp
mv /opt/conda/pkgs/notebook-4.2.3-py35_0/lib/python3.5/site-packages/notebook/templates/tree.html.tmp /opt/conda/pkgs/notebook-4.2.3-py35_0/lib/python3.5/site-packages/notebook/templates/tree.html    

if [ "$SPARK_MASTER_URL" == "" ]; then 
	SPARK_MASTER_URL="spark://$SPARK_MASTER_HOSTNAME:$SPARK_MASTER_PORT"
	echo "Using SPARK_MASTER_URL=$SPARK_MASTER_URL"
fi

export SPARK_OPTS="--driver-java-options=-$JAVA_DRIVER_OPTS --driver-java-options=-Dlog4j.logLevel=info --master $SPARK_MASTER_URL --files /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml"

if [ "$POSTGRES_HOSTNAME" != "" ]; then
	sed "s/POSTGRES_HOSTNAME/$POSTGRES_HOSTNAME/" /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml >> /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml.tmp && \
	mv /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml
fi

if [ "$POSTGRES_PORT" != "" ]; then
	sed "s/POSTGRES_PORT/$POSTGRES_PORT/" /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml >> /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml.tmp && \
	mv /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml
fi

if [ "$SPARK_POSTGRES_DB" != "" ]; then
	sed "s/SPARK_POSTGRES_DB/$SPARK_POSTGRES_DB/" /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml >> /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml.tmp && \
	mv /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml
fi

if [ "$SPARK_POSTGRES_USER" != "" ]; then
	sed "s/SPARK_POSTGRES_USER/$SPARK_POSTGRES_USER/" /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml >> /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml.tmp && \
	mv /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml
fi

if [ "$DYNAMIC_PARTITION_VALUE" != "" ]; then
	sed "s/DYNAMIC_PARTITION_VALUE/$DYNAMIC_PARTITION_VALUE/" /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml >> /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml.tmp && \
	mv /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml
fi

if [ "$DYNAMIC_PARTITION_MODE" != "" ]; then
	sed "s/DYNAMIC_PARTITION_MODE/$DYNAMIC_PARTITION_MODE/" /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml >> /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml.tmp && \
	mv /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml
fi

if [ "$NR_MAX_DYNAMIC_PARTITIONS" != "" ]; then
	sed "s/NR_MAX_DYNAMIC_PARTITIONS/$NR_MAX_DYNAMIC_PARTITIONS/" /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml >> /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml.tmp && \
	mv /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml
fi

if [ "$MAX_DYNAMIC_PARTITIONS_PER_NODE" != "" ]; then
	sed "s/MAX_DYNAMIC_PARTITIONS_PER_NODE/$MAX_DYNAMIC_PARTITIONS_PER_NODE/" /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml >> /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml.tmp && \
	mv /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml
fi

if [ "$SPARK_POSTGRES_PASSWORD" != "" ]; then
	sed "s/SPARK_POSTGRES_PASSWORD/$SPARK_POSTGRES_PASSWORD/" /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml >> /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml.tmp && \
	mv /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml
	cp /opt/spark-2.1.0-bin-hadoop2.7/conf/hive-site.xml /opt/hadoop/etc/hadoop/
	
	export PGPASSWORD=$POSTGRES_PASSWORD 

	psql -h $POSTGRES_HOSTNAME -p $POSTGRES_PORT  -U $POSTGRES_USER -d $POSTGRES_DB -c "CREATE USER $SPARK_POSTGRES_USER WITH PASSWORD '$SPARK_POSTGRES_PASSWORD';"

	psql -h $POSTGRES_HOSTNAME -p $POSTGRES_PORT  -U $POSTGRES_USER -d $POSTGRES_DB -c "CREATE DATABASE $SPARK_POSTGRES_DB;"

	psql -h $POSTGRES_HOSTNAME -p $POSTGRES_PORT  -U $POSTGRES_USER -d $POSTGRES_DB -c "grant all PRIVILEGES on database $SPARK_POSTGRES_DB to $SPARK_POSTGRES_USER;" 

	cd /opt/spark-2.1.0-bin-hadoop2.7/jars

	export PGPASSWORD=$SPARK_POSTGRES_PASSWORD

	psql -h $POSTGRES_HOSTNAME -p $POSTGRES_PORT  -U  $SPARK_POSTGRES_USER -d $SPARK_POSTGRES_DB -f /opt/spark-2.1.0-bin-hadoop2.7/jars/hive-schema-1.2.0.postgres.sql

	
	hdfs dfs -mkdir /tmp
	hdfs dfs -mkdir /tmp/hive 

	#Check if there is no workaround this permissions
	hdfs dfs -chmod -R 777 /tmp/hive
fi


if [ "$NOTEBOOK_PASSWORD" != "" ]; then
    pass=$(python /opt/password.py  $NOTEBOOK_PASSWORD)
    sed "s/#c.NotebookApp.password = u.*/c.NotebookApp.password = u\'$pass\'/" /root/.jupyter/jupyter_notebook_config.py >> /root/.jupyter/jupyter_notebook_config.py.tmp && \
	mv /root/.jupyter/jupyter_notebook_config.py.tmp /root/.jupyter/jupyter_notebook_config.py
    rm -rf /opt/password.py 
fi 

if [ "$EX_MEM" != "" ]; then
	sed "s/EX_MEM/$EX_MEM/" /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf >> /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp && \
	mv /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf
fi
if [ "$EX_CORES" != "" ]; then
	sed "s/EX_CORES/$EX_CORES/" /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf >> /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp && \
	mv /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf
fi
if [ "$DRIVER_MEM" != "" ]; then
	sed "s/DRIVER_MEM/$DRIVER_MEM/" /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf >> /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp && \
	mv /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf
fi
if [ "$DRIVER_CORES" != "" ]; then
	sed "s/DRIVER_CORES/$DRIVER_CORES/" /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf >> /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp && \
	mv /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf
fi

if [ "$SPARK_NETWORK_TIMEOUT" != "" ]; then
	sed "s/SPARK_NETWORK_TIMEOUT/$SPARK_NETWORK_TIMEOUT/" /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf >> /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp && \
	mv /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf
fi
if [ "$SPARK_RPC_TIMEOUT" != "" ]; then
	sed "s/SPARK_RPC_TIMEOUT/$SPARK_RPC_TIMEOUT/" /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf >> /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp && \
	mv /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf
fi

if [ "$SPARK_RPC_NUM_RETRIES" != "" ]; then
	sed "s/SPARK_RPC_NUM_RETRIES/$SPARK_RPC_NUM_RETRIES/" /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf >> /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp && \
	mv /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf.tmp /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-defaults.conf
fi

if [ "$MODE" == "" ]; then
MODE=$1
fi

CLASSPATH=/opt/spark-2.1.0-bin-hadoop2.7/jars/

if [ "$MODE" == "master" ]; then 
	${SPARK_HOME}/bin/spark-class "org.apache.spark.deploy.master.Master" -h $SPARK_MASTER_HOSTNAME --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT &
	jupyter notebook --ip=0.0.0.0 --log-level DEBUG

elif [ "$MODE" == "worker" ]; then
	${SPARK_HOME}/bin/spark-class "org.apache.spark.deploy.worker.Worker" --webui-port $SPARK_WORKER_WEBUI_PORT --port $SPARK_WORKER_PORT $SPARK_MASTER_URL -c $CORES -m $MEM 

elif [ "$MODE" == "thrift" ]; then 
	${SPARK_HOME}/bin/spark-class "org.apache.spark.deploy.master.Master" -h $SPARK_MASTER_HOSTNAME --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT &
	${SPARK_HOME}/bin/spark-submit --class org.apache.spark.sql.hive.thriftserver.HiveThriftServer2 --name "Thrift JDBC/ODBC Server"  --master $SPARK_MASTER_URL
else
	${SPARK_HOME}/bin/spark-class "org.apache.spark.deploy.master.Master" -h $SPARK_MASTER_HOSTNAME --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT &
	${SPARK_HOME}/bin/spark-class "org.apache.spark.deploy.worker.Worker" --webui-port $SPARK_WORKER_WEBUI_PORT --port $SPARK_WORKER_PORT $SPARK_MASTER_URL	-c $CORES -m $MEM  &
	jupyter notebook --ip=0.0.0.0 --log-level DEBUG
fi
