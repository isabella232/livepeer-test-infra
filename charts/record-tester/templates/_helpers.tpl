{{/*
Expand the name of the chart.
*/}}
{{- define "record-tester.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "record-tester.fullname" -}}
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

{{- define "record-tester.nameWithRegion" -}}
{{- list (include "record-tester.fullname" .root) .ecosystem .region | join "-" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "record-tester.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "record-tester.testerLabels" -}}
app.kubernetes.io/instance: {{ .root.Release.Name }}
test.livepeer.org/region: {{ .region }}
test.livepeer.org/ecosystem: {{ .ecosystem }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "record-tester.labels" -}}
helm.sh/chart: {{ include "record-tester.chart" . }}
{{ include "record-tester.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "record-tester.selectorLabels" -}}
app.kubernetes.io/name: {{ include "record-tester.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "record-tester.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "record-tester.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the list of endpoints for the analyzer based on regions and API endpoint.
*/}}
{{- define "record-tester.analyzer-endpoints" -}}
{{- $endpoints := list .livepeer_api_host -}}
{{- range $region := keys .regions | sortAlpha | concat (list "origin") -}}
  {{- $endpoints = append $endpoints (printf "%s.%s" $region $.livepeer_api_host) -}}
{{- end }}
{{- $endpoints | join "," -}}
{{- end }}
