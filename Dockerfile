FROM confluentinc/cp-enterprise-replicator-executable:7.4.0
USER root
RUN curl -sSL https://github.com/aws/aws-msk-iam-auth/releases/download/v1.1.6/aws-msk-iam-auth-1.1.6-all.jar -o /usr/share/java/kafka/aws-msk-iam-auth-1.1.6-all.jar
USER appuser
EXPOSE 8083
CMD ["/etc/confluent/docker/run"]