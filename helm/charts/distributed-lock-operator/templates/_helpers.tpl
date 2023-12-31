{{/*
   Copyright (c) 2023 Cloud Software Group, Inc.
   All Rights Reserved.

   File       : _helpers.tpl
   Version    : 1.0.0
   Description: Template helpers that can be shared with other charts.

    NOTES:
      - Helpers below are making some assumptions regarding files Chart.yaml and values.yaml. Change carefully!
      - Any change in this file needs to be synchronized with all charts
*/}}

{{/*
    ===========================================================================
    SECTION: consts
    ===========================================================================
*/}}

{{/* A fixed short name for the application. Can be different than the chart name */}}
{{- define "dp-core-distributed-lock-operator.consts.appName" }}distributed-lock-operator{{ end -}}

{{/* Component we're a part of. */}}
{{- define "dp-core-distributed-lock-operator.consts.component" }}dataplane{{ end -}}


{{- define "dp-core-distributed-lock-operator.consts.webhook" }}tibco-dp-{{ .Values.global.cp.dataplaneId }}-distributed-lock-operator-webhook{{ end -}}

{{/* Data plane workload type */}}
{{- define "dp-core-distributed-lock-operator.consts.workloadType" }}infra{{ end -}}

{{/* Namespace we're going into. */}}
{{- define "dp-core-distributed-lock-operator.consts.namespace" }}tibco-dp-{{ .Values.global.cp.dataplaneId }}{{ end -}}

{{/*
    ===========================================================================
    SECTION: labels
    ===========================================================================
*/}}

{{/* Create chart name and version as used by the chart label. */}}
{{- define "dp-core-distributed-lock-operator.shared.labels.chartLabelValue" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Selector labels used by the resources in this chart
*/}}
{{- define "dp-core-distributed-lock-operator.shared.labels.selector" -}}
app.kubernetes.io/name: {{ include "dp-core-distributed-lock-operator.consts.appName" . }}
app.kubernetes.io/component: {{ include "dp-core-distributed-lock-operator.consts.component" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Standard labels added to all resources created by this chart.
Includes labels used as selectors (i.e. template "labels.selector")
*/}}
{{- define "dp-core-distributed-lock-operator.shared.labels.standard" -}}
{{ include  "dp-core-distributed-lock-operator.shared.labels.selector" . }}
{{ include "dp-core-distributed-lock-operator.shared.labels.platform" . }}
helm.sh/chart: {{ include "dp-core-distributed-lock-operator.shared.labels.chartLabelValue" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
{{- end -}}

{{/* Platform labels to be added in all the resources created by this chart.*/}}
{{- define "dp-core-distributed-lock-operator.shared.labels.platform" -}}
platform.tibco.com/dataplane-id: {{ .Values.global.cp.dataplaneId }}
platform.tibco.com/workload-type: {{ include "dp-core-distributed-lock-operator.consts.workloadType" .}}
{{- end }}

{{/* Global resource prefix. */}}
{{- define "dp-core-distributed-lock-operator.shared.func.globalResourcePrefix" -}}
{{ .Values.global.cp.dataplaneId }}-{{ include "dp-core-distributed-lock-operator.consts.appName" . }}-
{{- end -}}
