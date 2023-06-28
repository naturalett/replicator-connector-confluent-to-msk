## The setup is based on the following documentation
https://docs.confluent.io/cloud/current/clusters/migrate-topics-on-cloud-clusters.html#run-crep-docker-container-with-kubernetes


## Build and push the docker image
```bash
docker build -t naturalett/cp-enterprise-replicator-executable:7.4.0 .
docker push naturalett/cp-enterprise-replicator-executable:7.4.0
```

## Create the configuration as a secret
```bash
export TOPIC=test-topic
```

## Generate the replication.properties
```bash
cat replicator/secrets-tpl/replication.properties.tpl | sed -e "s/TOPIC/${TOPIC}/" > replicator/secrets/replication.properties
```

## Generate the producer.properties
```bash
export MSK_BROKER_ENDPOINT_1=<FILL IT UP>
export MSK_BROKER_ENDPOINT_2=<FILL IT UP>
export MSK_BROKER_ENDPOINT_3=<FILL IT UP>
export MSK_CLUSTER_NAME=<FILL IT UP>
cat replicator/secrets-tpl/producer.properties.tpl | sed -e "s/MSK_BROKER_ENDPOINT_1/${MSK_BROKER_ENDPOINT_1}/" -e "s/MSK_BROKER_ENDPOINT_2/${MSK_BROKER_ENDPOINT_2}/" -e "s/MSK_BROKER_ENDPOINT_3/${MSK_BROKER_ENDPOINT_3}/" -e "s/MSK_CLUSTER_NAME/${MSK_CLUSTER_NAME}/" > replicator/secrets/producer.properties
```

## Generate the consumer.properties
```bash
export BOOTSTRAP_SERVERS=<FILL IT UP>
export BOOTSTRAP_USERNAME=<FILL IT UP>
export BOOTSTRAP_PASSWORD=<FILL IT UP>
cat replicator/secrets-tpl/consumer.properties.tpl | sed -e "s/BOOTSTRAP_SERVERS/${BOOTSTRAP_SERVERS}/" -e "s/BOOTSTRAP_USERNAME/${BOOTSTRAP_USERNAME}/" -e "s/BOOTSTRAP_PASSWORD/${BOOTSTRAP_PASSWORD}/" > replicator/secrets/consumer.properties
```

## Create the configuration secrets

```bash
kubectl create secret generic replicator-secret-props-${TOPIC} --from-file=replicator/secrets/ --namespace default
```

## Create the deployment
```bash
kubectl apply -f container/replicator-deployment.yaml

cat <<EOF | kubectl create -f -
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: repl-exec-connect-cluster-${TOPIC}
  namespace: default
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: replicator-app
    spec:
      containers:
        - name: confluent-replicator
          imagePullPolicy: IfNotPresent
          image: naturalett/cp-enterprise-replicator-executable:7.4.0
          resources:
            limits:
              cpu: "2"
              memory: 5Gi
            requests:
              cpu: "2"
              memory: 5Gi
          env:
            - name: CLUSTER_ID
              value: "replicator-k8s"
            - name: CLUSTER_THREADS
              value: "1"
            - name: CONNECT_GROUP_ID
              value: "containerized-repl"
            - name: KAFKA_HEAP_OPTS
              value: "-Xms2048M -Xmx4096M"

            - name: KAFKA_OPTS
              value: "-Djava.security.auth.login.config=/etc/replicator-config/jaas.conf"

              # Note: This is to avoid _overlay errors_ . You could use /etc/replicator/ here instead.
            - name: REPLICATION_CONFIG
              value: "/etc/replicator-config/replication.properties"
            - name: PRODUCER_CONFIG
              value: "/etc/replicator-config/producer.properties"
            - name: CONSUMER_CONFIG
              value: "/etc/replicator-config/consumer.properties"
          volumeMounts:
            - name: replicator-properties
              mountPath: /etc/replicator-config/
      volumes:
        - name: replicator-properties
          secret:
            secretName: "replicator-secret-props-${TOPIC}"
            defaultMode: 0666

EOF
```

## Delete the deployment
```bash
kubectl delete deployment -n default repl-exec-connect-cluster-${TOPIC}
```