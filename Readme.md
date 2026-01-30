# 🚀 AWS-Deployment

A **practical DevOps deployment repository** demonstrating how the same Flask (backend) and Express (frontend) application is deployed across **AWS EC2**, **AWS container orchestration**, and **local Kubernetes (Minikube)** setups.

This repository is organized to reflect the **chronological deployment order**: AWS first, then local Kubernetes.

---

# 🟩 PART 1 — AWS EC2 Deployments (VM-Based)

These deployments represent **traditional infrastructure models** commonly used in production.

## 1️⃣ Single EC2 Instance

**Pattern:** Monolithic VM deployment

**Overview:**

* Frontend and backend run on the same EC2 instance
* Communication via `localhost`

**Trade-offs:**

* ✔ Simple to operate
* ❌ Single point of failure
* ❌ Limited scalability

---

## 2️⃣ Separate EC2 Instances

**Pattern:** Two-tier distributed VM architecture

**Overview:**

* Frontend and backend deployed on separate EC2 instances
* Communication via **private IPs**
* Access controlled using **Security Groups**

**Trade-offs:**

* ✔ Better isolation
* ✔ Independent scaling
* ❌ Manual instance management

---

# 🟨 PART 2 — AWS Containerized Deployment (ECR + ECS + VPC)

This represents a **cloud-native evolution** of the same application.

## Architecture

* Applications packaged as Docker images
* Images stored in **Amazon ECR**
* Containers orchestrated using **Amazon ECS**
* Deployed inside a **custom VPC**
* External access via **Application Load Balancer** (where applicable)

**Characteristics:**

* Reduced operational overhead
* Native scaling and resilience
* Clear separation between application and infrastructure

---

# 🟦 PART 3 — Local Kubernetes Deployment (Minikube)

## Purpose

Used to simulate **production-style Kubernetes behavior** locally:

* Service discovery
* Pod abstraction
* Environment-based configuration

This mirrors how the same application would later run on EKS or GKE.

---

## 🧱 Architecture

**Pattern:** Two-tier Kubernetes application

```
User
 ↓
Frontend Service (NodePort)
 ↓
Frontend Pod(s)
 ↓  http://backend-service:5000
Backend Service (ClusterIP)
 ↓
Backend Pod(s)
```

### Design Choices

* **NodePort** exposes only the frontend (local cluster constraint)
* **ClusterIP** keeps the backend private
* Kubernetes Services provide **stable networking**
* Backend URL injected via **environment variables**

> ℹ️ Note: LoadBalancer is not used — Minikube does not provision managed LBs.

---

## ⚙️ Prerequisites

```bash
docker --version
kubectl version --client
minikube version
```

---

## 🚀 Deployment (Minikube)

```bash
# Clone repository
git clone https://github.com/PrathmmeshJagdale/AWS-Deployment.git
cd AWS-Deployment

# Start local Kubernetes cluster
minikube start

# Use Minikube Docker daemon (recommended)
eval $(minikube docker-env)

# Build application images
docker build -t backend-app:v1 ./backend
docker build -t frontend-app:v1 ./frontend

# Create isolated namespace
kubectl create namespace dev
kubectl config set-context --current --namespace=dev

# Deploy backend
kubectl apply -f k8s/backend-deployment.yaml
kubectl apply -f k8s/backend-service.yaml

# Deploy frontend
kubectl apply -f k8s/frontend-deployment.yaml
kubectl apply -f k8s/frontend-service.yaml

# Verify resources
kubectl get pods
kubectl get svc

# Access application
minikube service frontend-service -n dev
```

---

## 🔧 Configuration

Frontend resolves the backend using **Kubernetes DNS**:

```yaml
env:
  - name: BACKEND_URL
    value: "http://backend-service:5000"
```

---

## 🧪 Debugging

```bash
kubectl logs <pod-name>
kubectl describe pod <pod-name>
kubectl exec -it <pod-name> -- sh
```

---

## 🧹 Teardown

```bash
kubectl delete namespace dev
minikube stop
```

---

## 👤 Author

**Prathmmesh Jagdale**

---

⭐ If this repository helped you understand deployment architectures, consider giving it a STAR .
