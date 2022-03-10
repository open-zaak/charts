{{/*
Expand the name of the chart.
*/}}
{{- define "open-notificaties.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "open-notificaties.fullname" -}}
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
{{- define "open-notificaties.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "open-notificaties.commonLabels" -}}
helm.sh/chart: {{ include "open-notificaties.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Labels
*/}}
{{- define "open-notificaties.labels" -}}
{{ include "open-notificaties.commonLabels" . }}
{{ include "open-notificaties.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "open-notificaties.selectorLabels" -}}
app.kubernetes.io/name: {{ include "open-notificaties.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "open-notificaties.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "open-notificaties.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a name for the worker
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "open-notificaties.workerName" -}}
{{ include "open-notificaties.name" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "open-notificaties.workerFullname" -}}
{{ include "open-notificaties.fullname" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Worker labels
*/}}
{{- define "open-notificaties.workerLabels" -}}
{{ include "open-notificaties.commonLabels" . }}
{{ include "open-notificaties.workerSelectorLabels" . }}
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "open-notificaties.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "open-notificaties.workerName" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create a name for Flower
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "open-notificaties.flowerName" -}}
{{ include "open-notificaties.name" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Create a default fully qualified name for Flower.
We truncate at 57 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "open-notificaties.flowerFullname" -}}
{{ include "open-notificaties.fullname" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Flower labels
*/}}
{{- define "open-notificaties.flowerLabels" -}}
{{ include "open-notificaties.commonLabels" . }}
{{ include "open-notificaties.flowerSelectorLabels" . }}
{{- end }}

{{/*
Flower selector labels
*/}}
{{- define "open-notificaties.flowerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "open-notificaties.flowerName" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}