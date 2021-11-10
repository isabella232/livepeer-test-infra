{{/*
Expand the name of the chart.
*/}}
{{- define "cdn-puller.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cdn-puller.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- $suf := "prod" }}
{{- if .Values.cdnPuller.staging }}
{{- $suf = "staging" }}
{{- end }}
{{- if contains $name .Release.Name }}
{{- printf "%s-%s" .Release.Name $suf | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-%s" .Release.Name $name $suf | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}