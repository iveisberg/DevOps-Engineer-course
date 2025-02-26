{{/* Define common labels */}}
{{- define "app.labels" -}}
chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
release: {{ .Release.Name }}
heritage: {{ .Release.Service }}
{{- end -}}

{{/* Define service name */}}
{{- define "app.serviceName.frontend" -}}
{{ .Release.Name }}-{{ .Chart.Name }}-service-frontend
{{- end -}}

{{/* Define service name backend */}}
{{- define "app.serviceName.backend" -}}
{{ .Release.Name }}-{{ .Chart.Name }}-service-backend
{{- end -}}