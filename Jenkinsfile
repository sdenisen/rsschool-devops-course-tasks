pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "flask-hello:local"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'eval $(minikube docker-env) && docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Helm Upgrade') {
            steps {
                script {
                    sh 'helm upgrade --install flask-hello ./helm/simple-flask-app --namespace flask --create-namespace'
                }
            }
        }
    }
}
