pipeline {
    agent any

    environment {
        IMAGE_NAME = "ecommerce-app"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'devops-branch', url: 'https://github.com/umarmir/web-test.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    sh "docker build -t $IMAGE_NAME:latest ."
                }
            }
        }

        stage('Run with Docker Compose') {
            steps {
                script {
                    echo "Starting container with Docker Compose..."
                    sh 'docker-compose up -d'
                }
            }
        }

        stage('Health Check') {
            steps {
                script {
                    echo "Waiting for app to start..."
                    sleep 10
                    echo "Testing app on port 3000..."
                    // ✅ Fixed this line
                   sh 'curl --fail http://localhost:80 || (echo App failed to start! && exit 1)'
                }
            }
        }
    }

    post {
        success {
            echo "✅ Jenkins pipeline completed!"
        }
        failure {
            echo "❌ Pipeline failed. Check logs above."
        }
    }
}
