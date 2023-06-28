{{/*
Expand the name of the chart.
*/}}
{{- define "filesmanager.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "filesmanager.fullname" -}}
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
{{- define "filesmanager.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "filesmanager.labels" -}}
helm.sh/chart: {{ include "filesmanager.chart" . }}
{{ include "filesmanager.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "filesmanager.selectorLabels" -}}
app.kubernetes.io/name: {{ include "filesmanager.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "filesmanager.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "filesmanager.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Get PV name for persistent volume
*/}}
{{- define "filesmanager.persistentVolume.Name" -}}
{{- .existingName | default (printf "%s-%s" .releaseName .volumeName) -}}
{{- end -}}

{{/*
Integration storage folder pvc name
*/}}
{{- define "filesmanager.storage.pv.name" -}}
{{- include "filesmanager.persistentVolume.Name" (dict "existingName" .Values.volumes.filesmanager.existingName "releaseName" ( include "filesmanager.fullname" . ) "volumeName" "integration" ) -}}
{{- end -}}


{{/*
Get PVC name for persistent volume
*/}}
{{- define "filesmanager.persistentVolumeClaim.claimName" -}}
{{- .existingClaim | default (printf "%s-%s" .releaseName .volumeName) -}}
{{- end -}}

{{/*
Integration storage folder pvc name
*/}}
{{- define "filesmanager.storage.pvc.name" -}}
{{- include "filesmanager.persistentVolumeClaim.claimName" (dict "existingClaim" .Values.volumes.filesmanager.existingClaim "releaseName" ( include "filesmanager.fullname" . ) "volumeName" "integration" ) -}}
{{- end -}}
