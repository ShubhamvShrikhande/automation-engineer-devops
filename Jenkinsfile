pipeline {
    agent any

    environment {
        IMAGE_NAME = "automation-engineer-devops-flask"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Pulling code from GitHub"
                git branch: 'main', url: 'https://github.com/ShubhamvShrikhande/automation-engineer-devops.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image"
                script {
                    docker.build("${IMAGE_NAME}:latest", "./minimal-flask-example")
                }
            }
        }

        stage('Run Flask Container') {
            steps {
                echo "Running Flask container"
                script {
                    // Stop previous container if exists
                    sh 'docker rm -f flask_app || true'
                    docker.image("${IMAGE_NAME}:latest").run("-d -p 5000:5000 --name flask_app")
                }
            }
        }

        stage('Test App') {
            steps {
                echo "Testing Flask app"
                sh 'curl -f http://localhost:5000 || exit 1'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}

