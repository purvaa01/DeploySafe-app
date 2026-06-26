variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
  default     = "deploysafe"
}
variable "prometheus_chart_version" {
  default = "87.2.1"
}

variable "app_name" {
  description = "Application name"
  type        = string
}

variable "image" {
  description = "Docker image"
  type        = string
}

variable "replicas" {
  description = "Number of application replicas"
  type        = number
}

variable "service_type" {
  description = "Kubernetes Service type"
  type        = string
}

variable "ingress_host" {
  description = "Ingress hostname"
  type        = string
}