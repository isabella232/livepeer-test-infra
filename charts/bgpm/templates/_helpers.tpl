{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "bgpm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "bgpm.labels" -}}
helm.sh/chart: {{ include "bgpm.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Exporter Selector labels
*/}}
{{- define "bgpm.exporterSelectorLabels" -}}
app.kubernetes.io/name: {{ .Values.name }}-exporter
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Monitor Selector labels
*/}}
{{- define "bgpm.testerSelectorLabels" -}}
app.kubernetes.io/name: {{ .Values.name }}-selector
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
