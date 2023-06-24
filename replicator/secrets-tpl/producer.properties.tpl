bootstrap.servers=MSK_BROKER_ENDPOINT_1:9098,MSK_BROKER_ENDPOINT_2:9098,MSK_BROKER_ENDPOINT_3:9098
ssl.endpoint.identification.algorithm=https
sasl.mechanism=AWS_MSK_IAM
# sasl.jaas.config="software.amazon.msk.auth.iam.IAMLoginModule required;"
security.protocol=SASL_SSL
producer.override.bootstrap.servers=MSK_BROKER_ENDPOINT_1:9098,MSK_BROKER_ENDPOINT_2:9098,MSK_BROKER_ENDPOINT_3:9098
producer.override.sasl.mechanism=AWS_MSK_IAM
producer.override.security.protocol=SASL_SSL
producer.override.sasl.jaas.config=software.amazon.msk.auth.iam.IAMLoginModule required;
producer.override.ssl.endpoint.identification.algorithm=https
producer.override.equest.timeout.ms=20000
producer.override.retry.backoff.ms=500
producer.override.sasl.client.callback.handler.class=software.amazon.msk.auth.iam.IAMClientCallbackHandler


producer.sasl.client.callback.handler.class=software.amazon.msk.auth.iam.IAMClientCallbackHandler
sasl.client.callback.handler.class=software.amazon.msk.auth.iam.IAMClientCallbackHandler
client.sasl.client.callback.handler.class=software.amazon.msk.auth.iam.IAMClientCallbackHandler

producer.override.sasl.jaas.config=software.amazon.msk.auth.iam.IAMLoginModule required awsProfileName="MSK_CLUSTER_NAME";
sasl.jaas.config=software.amazon.msk.auth.iam.IAMLoginModule required awsProfileName="MSK_CLUSTER_NAME";
producer.sasl.jaas.config=software.amazon.msk.auth.iam.IAMLoginModule required awsProfileName="MSK_CLUSTER_NAME";
consumer.sasl.jaas.config=software.amazon.msk.auth.iam.IAMLoginModule required awsProfileName="MSK_CLUSTER_NAME";
