bootstrap.servers=BOOTSTRAP_SERVERS:9092
ssl.endpoint.identification.algorithm=https
security.protocol=SASL_SSL
sasl.mechanism=PLAIN
sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username="BOOTSTRAP_USERNAME" password="BOOTSTRAP_PASSWORD";
request.timeout.ms=20000
retry.backoff.ms=500

key.converter=io.confluent.connect.avro.AvroConverter
value.converter=io.confluent.connect.avro.AvroConverter
config.storage.topic=connect-configs
offset.storage.topic=connect-offsets
status.storage.topic=connect-statuses
key.converter.schemas.enable=true
value.converter.schema.enable=true
offset.flush.interval.ms=10000

group.id=connect-cluster
plugin.path=/usr/local/share/java