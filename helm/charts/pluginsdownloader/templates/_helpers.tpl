{{/*
Expand the name of the chart.
*/}}
{{- define "pluginsdownloader.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "pluginsdownloader.fullname" -}}
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
{{- define "pluginsdownloader.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "pluginsdownloader.labels" -}}
helm.sh/chart: {{ include "pluginsdownloader.chart" . }}
{{ include "pluginsdownloader.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "pluginsdownloader.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pluginsdownloader.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "pluginsdownloader.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "pluginsdownloader.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Integration storage folder pvc name
*/}}
{{- define "pluginsdownloader.storage.pvc.name" -}}
{{- include "pluginsdownloader.persistentVolumeClaim.claimName" (dict "existingClaim" .Values.volumes.pluginsdownloader.existingClaim "releaseName" ( include "pluginsdownloader.fullname" . ) "volumeName" "integration" ) -}}
{{- end -}}
