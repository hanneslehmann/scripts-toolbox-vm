#!/usr/bin/env bash
echo "Starting install Spark..." >> /var/log/bootstrap.log

### Download & Setup Spark
#wget http://d3kbcqa49mib13.cloudfront.net/spark-1.4.1-bin-without-hadoop.tgz -P /tmp
#cd /tmp && tar xzf /tmp/spark-1.4.1-bin-without-hadoop.tgz
#mv /tmp/spark-1.4.1-bin-without-hadoop /opt/spark

wget http://d3kbcqa49mib13.cloudfront.net/spark-1.4.1-bin-hadoop2.6.tgz -P /tmp
cd /tmp && tar xzf /tmp/spark-1.4.1-bin-hadoop2.6.tgz
mv /tmp/spark-1.4.1-bin-hadoop2.6 /opt/spark
echo "export SPARK_HOME=/opt/spark" >> /home/vagrant/.bashrc
cp /opt/spark/conf/spark-env.sh.template  /opt/spark/conf/spark-env.sh
echo "export SPARK_LOCAL_IP=127.0.0.1" >> /opt/spark/conf/spark-env.sh
echo "export SPARK_MASTER_IP=127.0.0.1" >> /opt/spark/conf/spark-env.sh
echo "export SPARK_MASTER_WEBUI_PORT=8084" >> /opt/spark/conf/spark-env.sh

# start spark master
/opt/spark/sbin/start-master.sh

### Setup Spark kernel
# Source: http://thepowerofdata.io/configuring-jupyteripython-notebook-to-work-with-pyspark-1-4-0/
mkdir -p /home/vagrant/.ipython/kernels/pyspark
chown vagrant:vagrant /home/vagrant/.ipython/kernels/pyspark
touch /home/vagrant/.ipython/kernels/pyspark/kernel.json
chown vagrant:vagrant /home/vagrant/.ipython/kernels/pyspark/kernel.json
cat << EOF > /home/vagrant/.ipython/kernels/pyspark/kernel.json
{
 "display_name": "pySpark (Spark 1.4.0)",
 "language": "python",
 "argv": [
  "/usr/bin/python2",
  "-m",
  "IPython.kernel",
  "-f",
  "{connection_file}"
 ],
 "env": {
  "SPARK_HOME": "/opt/spark",
  "PYTHONPATH": "/opt/spark/python/:/opt/spark/python/lib/py4j-0.8.2.1-src.zip",
  "PYTHONSTARTUP": "/opt/spark/python/pyspark/shell.py",
  "PYSPARK_SUBMIT_ARGS": "--master spark://127.0.0.1:7077 pyspark-shell"
 }
}
EOF
