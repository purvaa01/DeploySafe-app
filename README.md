# 🚀 DeploySafe – End-to-End DevOps CI/CD Pipeline

DeploySafe is a comprehensive DevOps project that automates the complete software delivery lifecycle—from code commit to Kubernetes deployment. It demonstrates modern DevOps practices including Infrastructure as Code, GitOps, Progressive Delivery, Monitoring, Alerting, and Automated Rollbacks using industry-standard tools.

---

## 📖 Project Overview

DeploySafe simulates a production-ready CI/CD platform with end-to-end automation. Every stage of the software delivery pipeline is automated and monitored, from initial code commit to live production deployment.

### ✨ Key Features

- **CI/CD Pipeline**: Automated build, test, and deployment workflows using Jenkins
- **Infrastructure as Code**: Provision and manage Kubernetes resources with Terraform
- **Container Security**: Vulnerability scanning with Trivy
- **GitOps**: Declarative infrastructure and deployment management using ArgoCD
- **Progressive Delivery**: Blue-Green deployments with Argo Rollouts and automated promotion
- **Observability**: Comprehensive monitoring with Prometheus and Grafana dashboards
- **Intelligent Alerting**: Prometheus rules and automated health verification
- **Automated Rollbacks**: Intelligent rollback on deployment failures
- **Notifications**: Real-time Slack alerts for pipeline events
- **Containerization**: FastAPI application packaged and deployed in Docker containers

---

## ⚙️ Architecture & Workflow

```text
Developer
      │
      ▼
GitHub Repository
      │
      ▼
Jenkins Pipeline
      │
      ├── Checkout Code
      ├── Build Docker Image
      ├── Trivy Security Scan
      ├── Push Image to DockerHub
      ├── Update GitOps Repository
      └── Slack Notifications
                │
                ▼
           ArgoCD Sync
                │
                ▼
        Argo Rollouts (Blue-Green)
                │
      ┌─────────┴──────────┐
      │                    │
   Active             Preview Service
   Service                 │
      │                    │
      └──── AnalysisTemplate ────► Health Checks
                      │
          Successful?  │
             Yes   │   No
              ▼       ▼
       Promote      Rollback
       Deployment       │
              │         │
              └────┬────┘
                   ▼
          Prometheus Monitoring
                   │
                   ▼
            Prometheus Alerts
                   │
                   ▼
           Grafana Dashboard
              & Slack Alerts
```

---

## 🛠 Tech Stack

| Category | Technologies |
|----------|--------------|
| **Programming Language** | Python |
| **Backend Framework** | FastAPI |
| **Containerization** | Docker |
| **Container Registry** | Docker Hub |
| **Infrastructure as Code** | Terraform |
| **CI/CD Orchestration** | Jenkins |
| **Version Control** | Git & GitHub |
| **Container Orchestration** | Kubernetes (K3s) |
| **GitOps Platform** | ArgoCD |
| **Progressive Delivery** | Argo Rollouts |
| **Monitoring** | Prometheus |
| **Visualization** | Grafana |
| **Metrics Collection** | Prometheus FastAPI Instrumentator |
| **Alerting** | Prometheus Rules |
| **Notifications** | Slack |
| **Security Scanning** | Trivy |
| **Operating System** | Ubuntu Linux |

---

## ✅ What Is Covered

### Infrastructure Management
- Kubernetes resource provisioning and management
- Terraform Infrastructure as Code (IaC)
- Namespace and RBAC configuration
- Service discovery and networking
- Deployment orchestration
- Horizontal Pod Autoscaler (HPA) for dynamic scaling
- Ingress configuration for external access

### CI/CD Pipeline
- Jenkins pipeline orchestration
- Docker image building and optimization
- DockerHub container registry integration
- Trivy vulnerability scanning and reporting
- Automated deployment to Kubernetes
- Pipeline health checks and notifications

### GitOps & Deployment
- ArgoCD installation and configuration
- GitOps repository management
- Automatic synchronization of declarative manifests
- Blue-Green deployment strategy
- Preview environments for testing
- Automated promotion and rollback

### Progressive Delivery
- Argo Rollouts integration
- Blue-Green deployment patterns
- Preview service deployment
- AnalysisTemplate for automated health checks
- Automated promotion on successful validation
- Instant rollback on failure detection

### Monitoring & Observability
- Prometheus installation and configuration
- Grafana dashboard creation and customization
- FastAPI metrics collection and exposure
- ServiceMonitor for Prometheus scraping
- Prometheus alerting rules and thresholds
- Alert lifecycle management and validation

### Notifications & Alerts
- Slack integration for real-time notifications
- Pipeline event notifications (Started, Success, Failure)
- Prometheus alert routing to Slack
- Custom alerting workflows

### Reliability & Safety
- Automated health verification and status checks
- Intelligent automatic rollback on failures
- Health endpoint validation and monitoring
- Deployment failure detection and recovery

---

## 📂 Project Structure

```
DeploySafe-app/
│
├── archive/                          # Archived files and backups
│
├── k8s/                              # Kubernetes manifests
│   ├── deployment.yaml              # Application deployment
│   ├── hpa.yaml                     # Horizontal Pod Autoscaler
│   ├── ingress.yaml                 # Ingress configuration
│   ├── namespace.yaml               # Namespace setup
│   └── service.yaml                 # Service configuration
│
├── monitoring/                       # Monitoring configuration
│   └── values.yaml                  # Prometheus/Grafana Helm values
│
├── scripts/                          # Automation scripts
│   ├── install-monitoring.sh        # Setup monitoring stack
│   ├── rollback.sh                  # Rollback automation
│   └── verify.sh                    # Health verification
│
├── terraform/                        # Infrastructure as Code
│   ├── argocd.tf                    # ArgoCD configuration
│   ├── monitoring.tf                # Monitoring stack setup
│   ├── namespace.tf                 # Namespace resources
│   ├── outputs.tf                   # Terraform outputs
│   ├── providers.tf                 # Provider configuration
│   ├── rollouts.tf                  # Argo Rollouts setup
│   ├── terraform.tfvars             # Variable values
│   └── variables.tf                 # Variable definitions
│
├── app.py                            # FastAPI application
├── Dockerfile                        # Docker image definition
├── Jenkinsfile                       # Jenkins pipeline definition
├── requirements.txt                  # Python dependencies
├── values.yaml                       # Default Helm values
├── default-values.yaml               # Fallback configuration
├── README.md                         # This file
└── .gitignore                        # Git ignore rules
```

---

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/purvaa01/DeploySafe-app.git
cd DeploySafe-app
```

### 2. Build Docker Image

```bash
docker build -t deploysafe-app:latest .
```

### 3. Deploy Infrastructure

```bash
cd terraform

terraform init
terraform plan
terraform apply
```

### 4. Install Monitoring Stack

```bash
cd ..
bash scripts/install-monitoring.sh
```

### 5. Configure and Run Jenkins Pipeline

Configure Jenkins with the following credentials:
- Docker Hub credentials for image registry
- Slack webhook for notifications
- Kubernetes cluster access credentials

Then trigger the Jenkins pipeline to start the CI/CD workflow.

---

## 📈 Future Enhancements

- **Alertmanager Integration**: Advanced alert routing and notifications to Slack, PagerDuty, and email
- **AWS EKS Deployment**: Full deployment on AWS EKS with production-grade networking, security groups, and VPC configuration
- **Cost Optimization**: Resource optimization and cost monitoring
- **Advanced Security**: Enhanced RBAC, network policies, and compliance scanning
- **Multi-Region Support**: Disaster recovery and multi-region deployment strategies

---

## 🎯 Learning Outcomes

By working with DeploySafe, you'll gain practical experience with:

- DevOps automation and best practices
- CI/CD pipeline design and implementation
- Infrastructure as Code principles and tools
- Kubernetes cluster administration
- GitOps workflows and declarative deployments
- Progressive delivery strategies
- Observability, monitoring, and alerting
- Container security and vulnerability management
- Automated rollback and failure recovery
- Production deployment strategies

---

## 🤝 Contributing

Contributions, suggestions, and improvements are welcome!

To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add your feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

Please ensure your contributions align with the project's goals and best practices.

---

## ⭐ Support

If you found this project helpful, please consider:
- ⭐ Starring the repository on GitHub
- 🔗 Sharing it with others
- 💬 Providing feedback or suggestions
- 🤝 Contributing improvements

Your support helps motivate future development and improvements!

