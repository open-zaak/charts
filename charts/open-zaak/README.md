# Open Zaak chart

The Helm chart installs Open Zaak and by default the following dependencies using subcharts:

- [PostgreSQL](https://github.com/bitnami/charts/tree/master/bitnami/postgresql)
- [Redis](https://github.com/bitnami/charts/tree/master/bitnami/redis)

## Installation

First configure the Helm repository:

```bash
helm repo add open-zaak https://open-zaak.github.io/charts/
helm repo update
```

Install the Helm chart with:

```bash
helm install open-zaak open-zaak/open-zaak \
    --set "settings.allowedHosts=open-zaak.gemeente.nl" \
    --set "ingress.enabled=true" \
    --set "ingress.hosts={open-zaak.gemeente.nl}"
```

:warning: The default settings are unsafe for production usage. Configure proper secrets, enable persistency and consider High Availability (HA) for the database and the application.

## Chart and Open Zaak versions alignment

Not every version of the chart is compatible with every version of Open Zaak. The
table below describes the supported versions

| Chart version | Open Zaak version |
| ------------- | ----------------- |
| < 0.5.0       | < 1.5.0 |
| 0.5.0         | 1.5.0 + |

## Configuration

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `tags.postgresql` | Install PostgreSQL subchart | `true` |
| `tags.redis` | Install Redis subchart | `true` |
| `image.repository` | The repository of the Docker image | `openzaak/open-zaak` |
| `image.tag` | The tag of the Docker image | `""` uses `.Chart.AppVersion` by default |
| `replicaCount` | The number of replicas | `1` |
| `podLabels` | Additional labels to be set on the open-zaak pods | `{}` |
| `ingress.enabled` | Expose the application through an ingress | `false` |
| `ingress.annotations` | Additional annotations on the API ingress | `{}` |
| `ingress.hosts` | Ingress hosts | `"{open-zaak.gemeente.nl}"` |
| `ingress.tls` | Ingress TLS settings | `"[]"` |
| `persistence.enabled` | Enable persistency for application media | `false` |
| `persistence.storageClassName` | Storage class name for the PVC creation, must support RWX | `""` |
| `persistence.size` | The size of the application media persistent volume | `"1Gi"` |
| `persistence.existingClaim` | Use an existing claim for application media | `null` |
| `existingSecret` | Refer to an existing secret to avoid managing secrets through Helm. See templates/secret.yaml for required contents of your existing secret | `null` |
| `initContainers.volumePerms` | Run the file-permission fix init container (for upgrades from Open Zaak < 1.5) | `true` |
| `settings.allowedHosts` | A comma-separated list of hosts allowed by the application | `"open-zaak.gemeente.nl"` |
| `settings.useXForwardedHost` | Whether to rely on the `X-Forwarded-Host` header from ingress for host detection | `false` |
| `settings.secretKey` | The secret key of the application | `"SOME-RANDOM-SECRET"` |
| `settings.database.host` | The hostname of PostgreSQL | `"open-zaak-postgresql"` |
| `settings.database.port` | The port of PostgreSQL | `5432` |
| `settings.database.username` | The username of PostgreSQL | `"postgres"` |
| `settings.database.password` | The password of PostgreSQL | `"SUPER-SECRET"` |
| `settings.database.name` | The database name of PostgreSQL | `"open-zaak"` |
| `settings.database.sslmode` | The SSL-mode used by the postgres client. See [docs](https://www.postgresql.org/docs/current/libpq-ssl.html) for more info | `"prefer"` |
| `settings.cache.default` | The Redis cache for the default cache | `"open-zaak-redis-master:6379/0"` |
| `settings.cache.axes` | The Redis cache for the axes cache | `"open-zaak-redis-master:6379/0"` |
| `settings.email.host` | The hostname of the SMTP server | `"localhost"` |
| `settings.email.port` | The port of the SMTP server | `25` |
| `settings.email.username` | The username of the SMTP server | `""` |
| `settings.email.password` | The password of the SMTP server | `""` |
| `settings.email.useTLS` | Use TLS for connecting to SMTP server | `false` |
| `settings.jwtExpiry` | The expiry time for JWT tokens | `3600` |
| `settings.cmis.enabled` | Enable CMIS | `false` |
| `settings.cmis.mapperFile` | The CMIS mapper file | `""` |
| `settings.sentry.dsn` | The DSN for Sentry Logging | `""` |
| `settings.isHttps` | Used to construct absolute URLs and controls a variety of security settings | `true` |
| `settings.debug` | Only set this to True on a local development environment. Various other security settings are derived from this setting | `false` |
| `nginx.podLabels` | Additional labels to be set on the nginx pods | `{}` |
| `postgresql.persistence.enabled` | Enable PostgreSQL persistency | `false` |
| `postgresql.persistence.size` | Configure PostgreSQL size | `"1Gi"` |
| `postgresql.persistence.existingClaim` | Use an existing persistent volume claim | `null` |
| `postgresql.postgresqlDatabase` | The PostgreSQL database name | `"open-zaak"` |
| `postgresql.postgresqlPassword` | The PostgreSQL administrative password | `"SUPER-SECRET"` |
| `redis.usePassword` | Use a Redis password | `false` |
| `redis.cluster.enabled` | Enable Redis cluster | `false` |
| `redis.persistence.existingClaim` | Use existing persistent volume claim for Redis | `""` |
| `redis.master.persistence.enabled` | Enable persistency for Redis master | `false` |
| `redis.master.persistence.size` | The size of the Redis master persistent volume | `"1Gi"` |

Check [values.yaml](./values.yaml) for all the possible configuration options.
