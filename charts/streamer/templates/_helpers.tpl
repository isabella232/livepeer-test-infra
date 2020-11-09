{{/*
Expand the name of the chart.
*/}}
{{- define "streamer.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "streamer.fullname" -}}
{{- $name := .Chart.Name }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "streamer.streamName" -}}
{{- if contains .root.Chart.Name .root.Release.Name }}
{{- printf "%s-%s" .root.Release.Name .stream.name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-%s" .root.Release.Name .root.Chart.Name .stream.name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "streamer.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Rtmp Selector labels
*/}}
{{- define "streamer.rtmpSelectorLabels" -}}
app.kubernetes.io/name: {{ include "streamer.name" .root }}
app.kubernetes.io/instance: {{ .root.Release.Name }}
test.livepeer.org/name: {{ .stream.name }}
test.livepeer.org/ingest_region: {{ .stream.ingest_region }}
test.livepeer.org/ingest_protocol: "rtmp"
test.livepeer.org/playback_region: {{ .stream.playback_region }}
{{- end }}

{{/*
Http Selector labels
*/}}
{{- define "streamer.httpSelectorLabels" -}}
app.kubernetes.io/name: {{ include "streamer.name" .root }}
app.kubernetes.io/instance: {{ .root.Release.Name }}
test.livepeer.org/name: {{ .stream.name }}
test.livepeer.org/duration: {{ .stream.duration }}
test.livepeer.org/ingest_region: {{ .protocol.playback_region }}
test.livepeer.org/ingest_protocol: "http"
test.livepeer.org/playback_region: {{ .protocol.ingest_region }}
{{- end }}

{{/*
Streamer labels
*/}}
{{- define "streamer.streamerLabels" -}}
app.kubernetes.io/instance: {{ .root.Release.Name }}
test.livepeer.org/duration: {{ .stream.broadcast_duration | quote }}
test.livepeer.org/ingest_region: {{ .stream.playback_region }}
test.livepeer.org/ingest_protocol: "rtmp"
test.livepeer.org/playback_region: {{ .stream.ingest_region }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "streamer.labels" -}}
helm.sh/chart: {{ include "streamer.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "streamer.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "streamer.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
