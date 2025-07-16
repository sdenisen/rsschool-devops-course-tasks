# 🚀 Flask App Deployment in Minikube using Helm

This guide explains how to build and deploy a simple Flask application using **Helm** and **Minikube**, without Docker Hub.

---

## 📦 Prerequisites

Make sure the following tools are installed:

* [Minikube](https://minikube.sigs.k8s.io/)
* [kubectl](https://kubernetes.io/docs/tasks/tools/)
* [Helm](https://helm.sh/)
* Docker

---

## 🧱 Project Structure

```
project-root/
├── src/
    ├──main.py
├── requirements.txt
├── Dockerfile
└── helm/
    └── simple-flask-app/
        ├── Chart.yaml
        ├── values.yaml
        └── templates/
            ├── deployment.yaml
            └── service.yaml
```

---

## 🔧 Step-by-step Guide

### 1. Start Minikube

```bash
minikube start
```

### 2. Use Minikube's Docker daemon

```bash
eval $(minikube docker-env)
```

### 3. Build the Docker image locally

```bash
docker build -t flask-hello:local .
```

---

### 5. Deploy the app using Helm

```bash
helm install flask-hello ./helm/simple-flask-app --namespace flask --create-namespace
```

---

### 6. Access the application

```bash
minikube service flask-hello-jenkins -n flask
```

Or manually find the NodePort:

```bash
kubectl get svc -n flask
```

Then open:

```
http://127.0.0.1:<NodePort>
```

---

## ✅ Result

You should see:

```
Hello, Minikube from Flask with love!
```

---

## 🧹 Cleanup

```bash
helm uninstall flask-hello -n flask
kubectl delete namespace flask
```

---

Happy deploying! 🎉
