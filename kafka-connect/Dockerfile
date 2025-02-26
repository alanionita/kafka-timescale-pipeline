FROM alpine:latest



RUN apk update && \
apk add --virtual jq

# ---
    
FROM confluentinc/cp-kafka-connect:latest
    
# ENV CONNECT_PLUGIN_PATH:"/usr/share/java,/usr/share/kafka/plugins"

# FROM confluentinc/cp-server-connect-base:7.9.0

# -----

RUN   confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:latest

# -----

# WORKDIR /kafka-connect

# RUN sudo yum install epel-release -y

# RUN sudo yum update -y

# RUN sudo yum install jq -y

COPY ./connector-configs ./connector-configs

COPY ./register-connectors.sh .

# RUN confluent local services connect connector load jdbc-source --config ./kafka/plugin-configs/sync-timescale.json
