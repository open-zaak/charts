# Open Zaak chart including PostgreSQL and Redis

The Helm chart installs Open Zaak and by the following dependencies using subcharts:

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
helm install open-zaak open-zaak/open-zaak-postgres-redis \
    --set "open-zaak.settings.allowedHosts=open-zaak.gemeente.nl" \
    --set "open-zaak.ingress.enabled=true" \
    --set "open-zaak.ingress.hosts={open-zaak.gemeente.nl}"
```

:warning: The default settings are unsafe for production usage. Configure proper secrets, enable persistency and consider High Availability (HA) for the database and the application.

**Because we are using these charts as dependencies, all values need to be prefixed with the name of the chart.**

| Chart      | Values                                                                                    | More Information                                                       | 
|------------|-------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| open-zaak  | [values.yaml](https://github.com/open-zaak/charts/blob/main/charts/open-zaak/values.yaml) | [Chart](https://github.com/open-zaak/charts/tree/main/charts/open-zaak) | 
| postgresql | [values.yaml](https://github.com/bitnami/charts/blob/main/bitnami/postgresql/values.yaml) | [Artifact Hub](https://artifacthub.io/packages/helm/bitnami/postgresql) | 
| redis      | [values.yaml](https://github.com/bitnami/charts/blob/main/bitnami/redis/values.yaml)      | [Artifact Hub](https://artifacthub.io/packages/helm/bitnami/redis)      |  
