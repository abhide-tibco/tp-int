{{/*
Expand the name of the chart.
*/}}
{{- define "flogoprovisioner.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "flogoprovisioner.fullname" }}flogoprovisioner{{ end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "flogoprovisioner.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "flogoprovisioner.labels" -}}
helm.sh/chart: {{ include "flogoprovisioner.chart" . }}
{{ include "flogoprovisioner.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "flogoprovisioner.selectorLabels" -}}
app.kubernetes.io/name: {{ include "flogoprovisioner.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: "flogo"
platform.tibco.com/workload-type: "capability-service"
platform.tibco.com/dataplane-id: {{ .Values.global.cp.dataplaneId }}
platform.tibco.com/capability-instance-id: {{ .Values.global.cp.instanceId }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "flogoprovisioner.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "flogoprovisioner.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Get PVC name for persistent volume
*/}}
{{- define "flogoprovisioner.persistentVolumeClaim.claimName" -}}
{{- .existingClaim | default (printf "%s-%s" .releaseName .volumeName) -}}
{{- end -}}

{{/*
Integration storage folder pvc name
*/}}
{{- define "flogoprovisioner.storage.pvc.name" -}}
{{- include "flogoprovisioner.persistentVolumeClaim.claimName" (dict "existingClaim" .Values.volumes.flogoprovisioner.existingClaim "releaseName" ( include "flogoprovisioner.fullname" . ) "volumeName" "integration" ) -}}
{{- end -}}

{{- define "flogoprovisioner.cp.domain" }}cp-proxy.tibco-dp-{{ .Values.global.cp.dataplaneId }}.svc.cluster.local{{ end -}}

{{- define "flogoprovisioner.sa" }}tp-dp-{{ .Values.global.cp.dataplaneId }}-sa{{ end -}}
{{- define "flogoprovisioner.role" }}tp-dp-{{ .Values.global.cp.dataplaneId }}-role{{ end -}}
{{- define "flogoprovisioner.role-bind" }}tp-dp-{{ .Values.global.cp.dataplaneId }}-role-bind{{ end -}}
