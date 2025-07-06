# Jenkins Deployment via Helm & GitHub Actions

This project provides a Helm chart and GitHub Actions workflow for deploying Jenkins into a Kubernetes cluster.

---

## 🚀 Prerequisites

* Kubernetes cluster (e.g. Minikube or kind)
* Helm installed (`v3.x`)
* `kubectl` installed and configured
* GitHub repository with actions enabled

---

## 📦 Helm Chart

The custom Helm chart for Jenkins is located in the `./jenkins` directory.

It includes:

* Persistent volume support
* Configurable storage class and volume size
* Default service exposure via NodePort

---

## 🛠 Installation Instructions

### 1. Install Jenkins with Helm:

```bash
helm install jenkins ./jenkins \
  --namespace jenkins \
  --create-namespace
```

To customize storage class and volume size:
```bash
helm install jenkins ./jenkins \
  --namespace jenkins \
  --set persistence.storageClass=jenkins-pv \
  --set persistence.size=20Gi
```

## 2. Access Jenkins:
If using Minikube:

```bash
kubectl port-forward svc/jenkins 8080:80 -n jenkins
```

Open in browser:
```aiignore
http://localhost:8080
```

Default credentials:
User: user
Password:
```aiignore
kubectl get secret --namespace jenkins jenkins -o jsonpath="{.data.jenkins-password}" | base64 --decode
```

