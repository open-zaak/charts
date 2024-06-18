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

If you want to use your own instance of Redis, Postgres and RabbitMQ instead, you can disable the subcharts:

```bash

helm install open-notificaties open-zaak/open-notificaties \
    --set "tags.redis=false" \
    --set "tags.postgresql=false" \
    --set "tags.rabbitmq=false" \
    --set "settings.database.host=postgres.gemeente.nl" \
    --set "settings.cache.default=redis.gemeente.nl:6379/1" \
    --set "settings.cache.axes=redis.gemeente.nl:6379/1" \
    --set "settings.celery.resultBackend=redis.gemeente.nl:6379/2" \
    --set "settings.messageBroker.host=rabbitmq.gemeente.nl" \
    --set "settings.allowedHosts=open-notificaties.gemeente.nl" \
    --set "ingress.enabled=true" \
    --set "ingress.hosts={open-notificaties.gemeente.nl}"
```

:warning: The default settings are unsafe for production usage. Configure proper secrets, enable persistency and consider High Availability (HA) for the database and the application.

## Chart and Open Notificaties versions alignment

Not every version of the chart is compatible with every version of Open Notificaties. The
table below describes the supported versions

| Chart version | Open Notificaties version |
| ------------- | ------------------------- |
| < 0.5.0       | < 1.2.0 |
| 0.5.0         | 1.2.x   |
| 0.7.0         | 1.3.0 + |
| 0.8.0         | 1.4.0 + |

## Configuration

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `tags.postgresql` | Install PostgreSQL subchart | `true` |
| `tags.redis` | Install Redis subchart | `true` |
| `tags.rabbitmq` | Install RabbitMQ subchart | `true` |
| `image.repository` | The repository of the Docker image | `openzaak/open-notificaties` |
| `image.tag` | The tag of the Docker image | `""` (uses `.Chart.AppVersion` by default) |
| `replicaCount` | The number of replicas | `1` |
| `podLabels` | Additional labels to be set on the open-notification API pods | `{}` |
| `ingress.enabled` | Expose the application through an ingress | `false` |
| `ingress.annotations` | Additional annotations on the API ingress | `{}` |
| `ingress.hosts` | Ingress hosts | `"{open-notificaties.gemeente.nl}"` |
| `ingress.tls` | Ingress TLS settings | `"[]"` |
| `existingSecret` | Refer to an existing secret to avoid managing secrets through Helm. See templates/secret.yaml for required contents of your existing secret. This secret is also used for the Worker and Flower components. | `null` |
| `settings.allowedHosts` | A comma-separated list of hosts allowed by the application | `"open-notificaties.gemeente.nl"` |
| `settings.secretKey` | The secret key of the application | `"SOME-RANDOM-SECRET"` |
| `settings.database.host` | The hostname of PostgreSQL | `"open-notificaties-postgresql"` |
| `settings.database.port` | The port of PostgreSQL | `5432` |
| `settings.database.username` | The username of PostgreSQL | `"postgres"` |
| `settings.database.password` | The password of PostgreSQL | `"SUPER-SECRET"` |
| `settings.database.name` | The database name of PostgreSQL | `"open-notificaties"` |
| `settings.database.sslmode` | The SSL-mode used by the postgres client. See [docs](https://www.postgresql.org/docs/current/libpq-ssl.html) for more info | `"prefer"` |
| `settings.numProxies` | The number of reverse proxies between client and backend container. Set this to 1 if exposing the application through an ingress | `0`  |
| `settings.cache.default` | The Redis cache for the default cache | `"open-notificaties-redis-master:6379/0"` |
| `settings.cache.axes` | The Redis cache for the axes cache | `"open-notificaties-redis-master:6379/0"` |
| `settings.email.host` | The hostname of the SMTP server | `"localhost"` |
| `settings.email.port` | The port of the SMTP server | `25` |
| `settings.email.username` | The username of the SMTP server | `""` |
| `settings.email.password` | The password of the SMTP server | `""` |
| `settings.email.useTLS` | Use TLS for connecting to SMTP server | `false` |
| `settings.sentry.dsn` | The DSN for Sentry Logging | `""` |
| `settings.messageBroker.host` | The URL to the Celery broker | `"open-notificaties-rabbitmq"` |
| `settings.celery.resultBackend` | The URL to the Celery result backend | `"redis://open-notificaties-redis-master:6379/1"` |
| `settings.isHttps` | Used to construct absolute URLs and controls a variety of security settings | `true` |
| `settings.debug` | Only set this to True on a local development environment. Various other security settings are derived from this setting | `false` |
| `settings.autoRetry.maxRetries` | Maximum number of notification delivery retries. If `null`, the upstream defaults are used. | `null` |
| `settings.autoRetry.backoff` | Exponential backoff, boolean or number. If a number, applies as a scale factor. If `null`, the upstream defaults are used. | `null` |
| `settings.autoRetry.backoffMax` | Upper limit (in seconds) of the exponential backoff. If `null`, the upstream defaults are used. | `null` |
| `settings.flower.urlPrefix` | If enabled, deploy Flower on a non-root URL | `""` |
| `settings.flower.basicAuth` | Secure Flower with [Basic Authentication](https://flower.readthedocs.io/en/latest/config.html#basic-auth). This is a comma-separated list of `username:password`. You should configure this when `flower.ingress.enabled` is set to true. | `""` |
| `worker.podLabels` | Additional labels to be set on the open-notification worker pods | `{}` |
| `postgresql.persistence.enabled` | Enable PostgreSQL persistency | `false` |
| `postgresql.persistence.size` | Configure PostgreSQL size | `"1Gi"` |
| `postgresql.persistence.existingClaim` | Use an existing persistent volume claim | `null` |
| `postgresql.postgresqlDatabase` | The PostgreSQL database name | `"open-notificaties"` |
| `postgresql.postgresqlPassword` | The PostgreSQL administrative password | `"SUPER-SECRET"` |
| `flower.enabled` | Whether or not to deploy the [Flower](https://flower.readthedocs.io/en/latest/) component, which is a monitoring tool for Celery  | `false` |
| `flower.replicaCount` | The number of replicas for Celery Flower | `1` | 
| `flower.podLabels` | Additional labels to be set for Celery Flower | `{}` | 
| `flower.extraEnvVars` | Configure Flower through additional environment variables. For a full list of possibilities, see [Flower config docs](https://flower.readthedocs.io/en/latest/config.html)  | `{}` | 
| `flower.extraEnvVarsSecret` | Configure Flower through additional environment variables. This property should contain secrets like basic-auth. For a full list of possibilities, see [Flower config docs](https://flower.readthedocs.io/en/latest/config.html) | `{}` |
| `flower.ingress.enabled` | Use a dedicated Ingress for Flower, which can act as a Management Ingress. When `Values.ingress.enabled` is set to true and this parameter to false, then Flower will be exposed on the main Ingress. | `false` | 
| `flower.ingress.annotations` | Additional annotations on the Flower Ingress | `{}` |
| `flower.ingress.hosts` | Flower Ingress hosts | `"{open-notificaties-flower.gemeente.nl}"` |
| `flower.ingress.tls` | Flower Ingress TLS settings | `"[]"` |
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
