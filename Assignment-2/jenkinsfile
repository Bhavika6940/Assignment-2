pipeline {
    agent any

    environment {
        ACR_LOGIN_SERVER = 'practice234registry.azurecr.io'     // <-- Replace with your ACR Login Server
        ACR_CREDENTIALS_ID = 'acr-service-principal-id'  // <-- Jenkins credentials ID (username/password for ACR)
        IMAGE_NAME = 'consoleapp'                  // <-- Your Docker image name
        REPO_URL = 'https://github.com/Bhavika6940/Assignment-2'  // <-- GitHub Repo
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: "${REPO_URL}", branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${ACR_LOGIN_SERVER}/${IMAGE_NAME}:latest")
                }
            }
        }

        stage('Login to ACR') {
            steps {
                script {
                    docker.withRegistry("https://${ACR_LOGIN_SERVER}", "${ACR_CREDENTIALS_ID}") {
                        echo 'Logged in to Azure Container Registry'
                    }
                }
            }
        }

        stage('Push Docker Image to ACR') {
            steps {
                script {
                    docker.withRegistry("https://${ACR_LOGIN_SERVER}", "${ACR_CREDENTIALS_ID}") {
                        dockerImage.push('latest')
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Successfully built and pushed the Docker image to ACR!"
        }
        failure {
            echo "Pipeline failed. Check errors above."
        }
    }
}
