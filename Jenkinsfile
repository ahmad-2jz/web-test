pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'ecommerce-app'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Clone the repo and checkout the correct branch
                git branch: 'devops-branch', url: 'https://github.com/umarmir/web-test.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
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
                    sleep 10 // Give app time to start
                    echo "Testing app on port 3000..."
                    sh 'curl --fail http://ecom-app:3000 || (echo "App failed to start!" && exit 1)'
                }
            }
        }

        stage('Clean Up') {
            steps {
                echo "Stopping and removing containers..."
                sh 'docker-compose down'
            }
        }
    }

    post {
        always {
            echo '✅ Jenkins pipeline completed!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs above.'
        }
    }
}
