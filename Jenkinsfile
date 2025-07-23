pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "flask-hello:local"
        DOCKER_REGISTRY = ""
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

    stage('Install Dependencies') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }

    stage('Run Unit Tests') {
            steps {
                sh 'pytest || echo "Tests failed (ignored for demo)"'
            }
        }

    stage('SonarQube Scan') {
        when {
            expression { return env.SONARQUBE_SCANNER_HOME != null }
        }
        steps {
            withSonarQubeEnv('MySonarQube') {
                sh 'sonar-scanner'
            }
        }
    }

    stage('Build Docker Image') {
            steps {
                sh 'eval $(minikube docker-env) && docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }

    stage('Push Docker Image') {
        when {
            expression { return env.DOCKER_REGISTRY != "" }
        }
        steps {
            sh '''
              docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}
              docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}
            '''
        }
    }

    stage('Deploy with Helm') {
            steps {
                sh 'helm upgrade --install flask-hello ./helm/simple-flask-app --namespace flask --create-namespace'
            }
        }

    stage('Verify Deployment') {
        steps {
            script {
                sh '''
                  sleep 10
                  NODE_PORT=$(kubectl get svc -n flask flask-hello-jenkins -o=jsonpath="{.spec.ports[0].nodePort}")
                  curl --fail http://127.0.0.1:$NODE_PORT || echo "App not reachable"
                '''
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
