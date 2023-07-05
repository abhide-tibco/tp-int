{{/* 
   Copyright (c) 2019 Cloud Software Group Inc.
   All Rights Reserved.

   File       : _shared.tpl
   Version    : 1.0.0
   Description: Template helpers that can be shared with other charts. 
   
    NOTES: 
      - Helpers below are making some assumptions regarding files Chart.yaml and values.yaml. Change carefully!
      - Any change in this file needs to be synchronized with all charts
*/}}


{{/* A fixed short name for the application. Can be different than the chart name */}}
{{- define "tp-log-proxy.consts.appName" }}tp-log-proxy{{ end -}}


{{/*
    ===========================================================================
    SECTION: labels
    ===========================================================================
*/}}

{{/* Create chart name and version as used by the chart label. */}}
{{- define "tp-log-proxy.shared.labels.chartLabelValue" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Selector labels used by the resources in this chart
*/}}
{{- define "tp-log-proxy.shared.labels.selector" -}}
app.kubernetes.io/name: {{ include "tp-log-proxy.consts.appName" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: "bwce"
platform.tibco.com/workload-type: "capability-service"
platform.tibco.com/dataplane-id: {{ .Values.global.cp.dataplaneId }}
{{- end -}}

{{/*
Standard labels added to all resources created by this chart.
Includes labels used as selectors (i.e. template "labels.selector")
*/}}
{{- define "tp-log-proxy.shared.labels.standard" -}}
{{ include  "tp-log-proxy.shared.labels.selector" . }}
app.cloud.tibco.com/created-by: {{ include "tp-log-proxy.consts.team" . }}
helm.sh/chart: {{ include "tp-log-proxy.shared.labels.chartLabelValue" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
{{- end -}}

