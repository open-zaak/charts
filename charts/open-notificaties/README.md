# Open Notificaties chart

The Helm chart installs Open Notificaties and by default the following dependencies using subcharts:

- [PostgreSQL](https://github.com/bitnami/charts/tree/master/bitnami/postgresql)
- [Redis](https://github.com/bitnami/charts/tree/master/bitnami/redis)
- [RabbitMQ](https://github.com/bitnami/charts/tree/master/bitnami/rabbitmq)

## Installation

First configure the Helm repository:

```bash
helm repo add open-zaak https://open-zaak.github.io/charts/
helm repo update
```

Install the Helm chart with:

```bash
helm install open-notificaties open-zaak/open-notificaties \
    --set "settings.allowedHosts=open-notificaties.gemeente.nl" \
    --set "ingress.enabled=true" \
    --set "ingress.hosts={open-notificaties.gemeente.nl}"
```

:warning: The default settings are unsafe for production usage. Configure proper secrets, enable persistency and consider High Availability (HA) for the database and the application.

## Configuration

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `tags.postgresql` | Install PostgreSQL subchart | `true` |
| `tags.redis` | Install Redis subchart | `true` |
| `tags.rabbitmq` | Install RabbitMQ subchart | `true` |
| `image.repository` | The repository of the Docker image | `openzaak/open-notificaties` |
| `image.tag` | The tag of the Docker image | `latest` |
| `replicaCount` | The number of replicas | `1` |
| `ingress.enabled` | Expose the application through an ingress | `false` |
| `ingress.annotations` | Additional annotations on the API ingress | `{}` |
| `ingress.hosts` | Ingress hosts | `"{open-notificaties.gemeente.nl}"` |
| `ingress.tls` | Ingress TLS settings | `"[]"` |
| `persistence.enabled` | Enable persistency for application media | `false` |
| `persistence.size` | The size of the application media persistent volume | `"1Gi"` |
| `persistence.existingClaim` | Use an existing claim for application media | `null` |
| `settings.allowedHosts` | A comma-separated list of hosts allowed by the application | `"open-notificaties.gemeente.nl"` |
| `settings.secretKey` | The secret key of the application | `"SOME-RANDOM-SECRET"` |
| `settings.database.host` | The hostname of PostgreSQL | `"open-notificaties-postgresql"` |
| `settings.database.port` | The port of PostgreSQL | `5432` |
| `settings.database.username` | The username of PostgreSQL | `"postgres"` |
| `settings.database.password` | The password of PostgreSQL | `"SUPER-SECRET"` |
| `settings.database.name` | The database name of PostgreSQL | `"open-notificaties"` |
| `settings.cache.default` | The Redis cache for the default cache | `"open-notificaties-redis-master:6379/0"` |
| `settings.cache.axes` | The Redis cache for the axes cache | `"open-notificaties-redis-master:6379/0"` |
| `settings.email.host` | The hostname of the SMTP server | `"localhost"` |
| `settings.email.port` | The port of the SMTP server | `25` |
| `settings.email.username` | The username of the SMTP server | `""` |
| `settings.email.password` | The password of the SMTP server | `""` |
| `settings.email.useTLS` | Use TLS for connecting to SMTP server | `false` |
| `settings.email.useTLS` | Use TLS for connecting to SMTP server | `false` |
| `settings.sentry.dsn` | The DSN for Sentry Logging | `""` |
| `settings.publisherBrokerUrl` | The URL to the publisher broker | `"amqp://guest:guest@open-notificaties-rabbitmq:5672/%2F"` |
| `settings.celeryBrokerUrl` | The URL to the Celery broker | `"amqp://guest:guest@open-notificaties-rabbitmq:5672//"` |
| `settings.celeryResultBackend` | The URL to the Celery result backend | `"amqp://guest:guest@open-notificaties-rabbitmq:5672//"` |
| `postgresql.persistence.enabled` | Enable PostgreSQL persistency | `false` |
| `postgresql.persistence.size` | Configure PostgreSQL size | `"1Gi"` |
| `postgresql.persistence.existingClaim` | Use an existing persistent volume claim | `null` |
| `postgresql.postgresqlDatabase` | The PostgreSQL database name | `"open-notificaties"` |
| `postgresql.postgresqlPassword` | The PostgreSQL administrative password | `"SUPER-SECRET"` |
| `redis.usePassword` | Use a Redis password | `false` |
| `redis.cluster.enabled` | Enable Redis cluster | `false` |
| `redis.persistence.existingClaim` | Use existing persistent volume claim for Redis | `""` |
| `redis.master.persistence.enabled` | Enable persistency for Redis master | `false` |
| `redis.master.persistence.size` | The size of the Redis master persistent volume | `"1Gi"` |
| `rabbitmq.auth.username` | RabbitMQ username | `"guest"` |
| `rabbitmq.auth.password` | RabbitMQ password | `"guest"` |
| `rabbitmq.auth.erlangCookie` | RabbitMQ Erlang Cookie | `"SUPER-SECRET"` |
| `rabbitmq.persistence.enabled` | Enable RabbitMQ persistency | `false` |
| `rabbitmq.persistence.size` | Configure RabbitMQ size | `"1Gi"` |
| `rabbitmq.persistence.existingClaim` | Use an existing persistent volume claim | `null` |

Check [values.yaml](./values.yaml) for all the possible configuration options.
