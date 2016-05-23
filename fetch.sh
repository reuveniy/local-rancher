#!/bin/bash -eux
for d in \
   rancher/agent:v1.0.1 \
   ubuntu \
   mysql \
   rancher/server \
   rancher/agent \
   eventstore/eventstore \
   rsmoorthy/mssql \
   consul \
   node \
   sebfia/fsharp-web \
   fsharp/fsharp \
   microsoft/aspnet \
   microsoft/aspnet:1.0.0-rc1-update1-coreclr \
   jenkins \
   java \
   haproxy \
   cassandra \
   sonarqube \
   mono \
   notary:server \
   notary:signer \
   solr \
   aerospike \
   wurstmeister/kafka \
   spotify/kafka \
   elasticsearch \
   mkobit/nifi \
   hashicorp/terraform \
   mesoscloud/mesos-master \
   mesoscloud/mesos-slave \
   yaronr/mesos \
   qnib/flink
do
   #if [ -n "$(sudo docker images | grep localhost | sed 's/localhost:5000\///g' | awk '{ print $1 }' | grep $d)" ]; then continue; fi;
   sudo docker pull $d && \
   sudo docker tag $d localhost:5000/$d && \
   sudo docker push localhost:5000/$d && \
   sudo docker rmi $d
   sudo docker images -q | xargs sudo docker rmi 2>/dev/null || true
   exit
done
