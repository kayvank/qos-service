

docker run -d -v /dev/shm:/dev/shm -p 5432:5432 pipelinedb/pipelinedb:latest

## run these sqls
##create user qos with password 'qos' createdb;
###create database qos with owner qos;

psql -h localhost -U qos < ../pipeline.qos.schema.backup.sql.txt


if [[ $# -lt 1 ]]; then 
  echo "usage is $0 dockeriamge" 
  exit -1
fi
##for i in `docker ps -a | grep 'qos' | awk '{print $1}'`;do docker rm -f $i;done
##for i in `docker images | grep 'qos' | awk '{print $3}'`;do docker rmi -f  $i;done

