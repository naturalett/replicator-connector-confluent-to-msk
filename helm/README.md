# Generate the replicator-conf

## Create the configuration as a secret
```bash
export TOPIC=test-topic
```

## Generate the replication.properties
```bash
cat replicator/secrets-tpl/replication.properties.tpl | sed -e "s/TOPIC/${TOPIC}/" > helm/replicator-conf/replication.properties
```

## Generate the producer.properties
```bash
export MSK_BROKER_ENDPOINT_1=<FILL IT UP>
export MSK_BROKER_ENDPOINT_2=<FILL IT UP>
export MSK_BROKER_ENDPOINT_3=<FILL IT UP>
export MSK_CLUSTER_NAME=<FILL IT UP>
cat replicator/secrets-tpl/producer.properties.tpl | sed -e "s/MSK_BROKER_ENDPOINT_1/${MSK_BROKER_ENDPOINT_1}/" -e "s/MSK_BROKER_ENDPOINT_2/${MSK_BROKER_ENDPOINT_2}/" -e "s/MSK_BROKER_ENDPOINT_3/${MSK_BROKER_ENDPOINT_3}/" -e "s/MSK_CLUSTER_NAME/${MSK_CLUSTER_NAME}/" > helm/replicator-conf/producer.properties
```

## Generate the consumer.properties
```bash
export BOOTSTRAP_SERVERS=<FILL IT UP>
export BOOTSTRAP_USERNAME=<FILL IT UP>
export BOOTSTRAP_PASSWORD=<FILL IT UP>
cat replicator/secrets-tpl/consumer.properties.tpl | sed -e "s/BOOTSTRAP_SERVERS/${BOOTSTRAP_SERVERS}/" -e "s/BOOTSTRAP_USERNAME/${BOOTSTRAP_USERNAME}/" -e "s/BOOTSTRAP_PASSWORD/${BOOTSTRAP_PASSWORD}/" > helm/replicator-conf/consumer.properties
```
