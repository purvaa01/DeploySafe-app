# DeploySafe

DeploySafe is a cloud-native DevOps project that demonstrates how a modern application is built, containerized, deployed, monitored, and managed on Kubernetes using Infrastructure as Code. The project follows production-inspired DevOps practices, including automated CI/CD, zero-downtime deployment strategies, monitoring, and scalable infrastructure management.

---

# Project Overview

DeploySafe showcases an end-to-end DevOps workflow, covering the complete lifecycle of deploying an application into Kubernetes.

### Features

* REST API built with FastAPI
* Docker containerization
* Automated CI/CD using Jenkins
* Docker Hub image publishing
* Kubernetes deployment on Minikube
* Infrastructure provisioning with Terraform
* Rolling Update deployment strategy
* Blue-Green deployment strategy
* Horizontal Pod Autoscaler (HPA)
* Prometheus monitoring
* Grafana dashboards
* Kubernetes health checks using Readiness & Liveness Probes

---

---

# Project Workflow

The DeploySafe pipeline follows the complete application deployment lifecycle:

1. **Developer writes code** for the FastAPI application.

2. **Source code is pushed to GitHub**, triggering the CI/CD pipeline.

3. **Jenkins Pipeline** starts automatically and:
    - Pulls the latest source code
    - Installs project dependencies
    - Builds the Docker image
    - Pushes the Docker image to Docker Hub

4. **Terraform provisions the Kubernetes infrastructure**, including:
    - Namespace
    - Deployment
    - Service
    - Ingress
    - Horizontal Pod Autoscaler (HPA)
    - Prometheus
    - Grafana

5. **Kubernetes deploys the application** using the latest Docker image.

6. **Rolling Update strategy** ensures zero-downtime deployments by gradually replacing old pods with new ones.

7. **Blue-Green Deployment** allows traffic to switch between two identical environments (Blue and Green) for safer releases.

8. **Kubernetes Services and Ingress** route incoming traffic to the active application deployment.

9. **Horizontal Pod Autoscaler (HPA)** automatically scales application pods based on CPU utilization.

10. **Prometheus continuously collects metrics** from the Kubernetes cluster and application.

11. **Grafana visualizes the collected metrics** through dashboards, providing real-time insights into application health and cluster performance.

12. **Readiness and Liveness probes** continuously monitor container health, ensuring only healthy pods receive traffic.
---

# Tech Stack

| Category                | Technologies                         |
| ----------------------- | ------------------------------------ |
| Backend                 | FastAPI, Python                      |
| Containerization        | Docker                               |
| CI/CD                   | Jenkins                              |
| Container Registry      | Docker Hub                           |
| Container Orchestration | Kubernetes (Minikube)                |
| Infrastructure as Code  | Terraform                            |
| Monitoring              | Prometheus, Grafana                  |
| Deployment Strategy     | Rolling Update, Blue-Green           |
| Scaling                 | Kubernetes Horizontal Pod Autoscaler |
| Networking              | Kubernetes Service, Ingress          |
| Operating System        | Ubuntu (WSL)                         |

---

# What is Covered in this Project

## Application Development

* Developed a REST API using FastAPI.
* Implemented health endpoints for Kubernetes health checks.
* Created a lightweight and production-ready Docker image.

## Containerization

* Dockerized the application.
* Multi-step Docker build process.
* Image versioning and publishing to Docker Hub.

## Continuous Integration

* Jenkins pipeline automation.
* Automatic Docker image build.
* Automatic image push to Docker Hub.
* Pipeline-driven deployment workflow.

## Kubernetes Deployment

* Namespace creation.
* Deployment management.
* Service exposure.
* Ingress configuration.
* Readiness Probe.
* Liveness Probe.
* Resource Requests and Limits.

## Infrastructure as Code

Terraform manages the Kubernetes infrastructure, including:

* Namespace
* Deployment
* Service
* Ingress
* Horizontal Pod Autoscaler
* Prometheus installation
* Grafana installation

## Deployment Strategies

Implemented production-style deployment techniques:

* Rolling Updates
* Blue-Green Deployment
* Zero-downtime service switching
* Traffic routing using Kubernetes Services

## Auto Scaling

* Horizontal Pod Autoscaler
* CPU-based scaling
* Configurable minimum and maximum replicas

## Monitoring & Observability

* Prometheus deployment
* Grafana deployment
* Kubernetes metrics collection
* Application monitoring dashboards

---

# Folder Structure

```text
DeploySafe-app/
│
├── k8s/
│   ├── deployment.yaml
│   ├── hpa.yaml
│   ├── ingress.yaml
│   ├── namespace.yaml
│   └── service.yaml
│
├── scripts/
│   └── install-monitoring.sh
│
├──terraform/      
│   ├── blue-deployment.tf           
│   ├── deployment.tf                
│   ├── green-deployment.tf          
│   ├── hpa.tf                       
│   ├── ingress.tf                  
│   ├── monitoring.tf                
│   ├── namespace.tf                 
│   ├── outputs.tf                  
│   ├── providers.tf                 
│   ├── service.tf                  
│   ├── terraform.tfstate            
│   ├── terraform.tfstate.backup     
│   ├── terraform.tfvars             
│   └── variables.tf                 
│
├── .gitignore
├── app.py
├── Dockerfile
├── Jenkinsfile
├── README.md
└── requirements.txt
```

---

# Prerequisites

Before running the project, ensure the following tools are installed:

* Python 3.10+
* Docker
* Kubernetes (Minikube)
* kubectl
* Terraform
* Jenkins
* Git

---

# Clone the Repository

```bash
git clone https://github.com/<your-github-username>/DeploySafe-app.git
```

```bash
cd DeploySafe-app
```

---

# Run the Project

## 1. Install Python Dependencies

```bash
pip install -r requirements.txt
```

## 2. Run the FastAPI Application

```bash
uvicorn app:app --reload
```

The application will be available at:

```
http://localhost:8000
```

API Documentation:

```
http://localhost:8000/docs
```

---

## Build the Docker Image

```bash
docker build -t deploysafe-app .
```

---

## Run the Docker Container

```bash
docker run -p 8000:8000 deploysafe-app
```

---

## Deploy to Kubernetes

Apply Kubernetes manifests:

```bash
kubectl apply -f k8s/
```

---

## Deploy Infrastructure with Terraform

```bash
cd terraform
```

Initialize Terraform:

```bash
terraform init
```

Review the execution plan:

```bash
terraform plan
```

Provision the infrastructure:

```bash
terraform apply
```

---

## Install Monitoring Stack

```bash
chmod +x scripts/install-monitoring.sh
./scripts/install-monitoring.sh
```

---

# Current Progress

* ✅ FastAPI Application
* ✅ Docker Containerization
* ✅ Jenkins CI Pipeline
* ✅ Docker Hub Integration
* ✅ Kubernetes Deployment
* ✅ Terraform Infrastructure
* ✅ Rolling Update Strategy
* ✅ Blue-Green Deployment
* ✅ Horizontal Pod Autoscaler
* ✅ Prometheus Monitoring
* ✅ Grafana Dashboards

---

# Future Enhancements

* Automatic Rollback Mechanism
* GitOps with ArgoCD
* Canary Deployments
* Production Hardening
* AI-based Self-Healing Deployments
