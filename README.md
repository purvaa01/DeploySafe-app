# DeploySafe: A Production-Grade CI/CD Pipeline

## Description

DeploySafe is an end-to-end DevOps project that demonstrates how an application moves from code to production using CI/CD, containerization, Kubernetes, and monitoring.
It focuses on building a production-like pipeline with automation, scalability, and observability.

---

## Project Overview

* Built a FastAPI-based application
* Containerized the application using Docker
* Implemented CI pipeline using Jenkins
* Integrated Trivy for security scanning
* Deployed application on Kubernetes
* Configured Ingress for external access
* Implemented Horizontal Pod Autoscaler (HPA)
* Set up monitoring using Prometheus and Grafana via Helm

---

## Flow (How It Works)

1. Developer pushes code to GitHub
2. Jenkins detects changes (SCM polling)
3. Jenkins pipeline:

    * Builds Docker image
    * Scans image using Trivy
    * Pushes image to DockerHub
4. Kubernetes pulls the latest image
5. Application is deployed using Deployment & Service
6. Ingress exposes the application externally
7. HPA automatically scales pods based on CPU usage
8. Prometheus collects metrics and Grafana visualizes them

---

## Tech Stack

| Category         | Tools/Technologies         |
| ---------------- | -------------------------- |
| Application      | FastAPI                    |
| Containerization | Docker                     |
| CI/CD            | Jenkins                    |
| Security         | Trivy                      |
| Orchestration    | Kubernetes (Minikube)      |
| Monitoring       | Prometheus, Grafana (Helm) |

---

## What is Covered in This Project

* End-to-end CI pipeline setup using Jenkins
* Docker image build and tagging strategy
* Container security scanning with Trivy
* Kubernetes deployment with:

    * Deployment
    * Service
    * Ingress
    * Namespace
    * HPA (Auto Scaling)
* Monitoring setup using Helm (Prometheus + Grafana)
* Real-time scaling validation using load testing

---

## Folder Structure

```
.
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── hpa.yaml
│   └── namespace.yaml
│
├── scripts/
│   └── install-monitoring.sh
│
├── app.py
├── Dockerfile
├── Jenkinsfile
├── requirements.txt
└── README.md
```

---

## How to Clone the Repository

```bash
git clone https://github.com/purvaa01/DeploySafe-app.git
cd deploysafe
```

---
