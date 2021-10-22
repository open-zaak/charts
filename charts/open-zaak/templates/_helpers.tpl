{{/*
Expand the name of the chart.
*/}}
{{- define "open-zaak.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "open-zaak.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "open-zaak.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "open-zaak.commonLabels" -}}
helm.sh/chart: {{ include "open-zaak.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Open Zaak labels
*/}}
{{- define "open-zaak.labels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "open-zaak.commonLabels" . }}
{{ include "open-zaak.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "open-zaak.selectorLabels" -}}
app.kubernetes.io/name: {{ include "open-zaak.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "open-zaak.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "open-zaak.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a name for NGINX
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "open-zaak.nginxName" -}}
{{ include "open-zaak.name" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
Create a default fully qualified name for NGINX.
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "open-zaak.nginxFullname" -}}
{{ include "open-zaak.fullname" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
NGINX labels
*/}}
{{- define "open-zaak.nginxLabels" -}}
{{ include "open-zaak.commonLabels" . }}
{{ include "open-zaak.nginxSelectorLabels" . }}
{{- end }}

{{/*
NGINX selector labels
*/}}
{{- define "open-zaak.nginxSelectorLabels" -}}
app.kubernetes.io/name: {{ include "open-zaak.nginxName" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
