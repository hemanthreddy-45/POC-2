pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "your-docker-image" // Replace with your Docker image name
        SONARQUBE_SERVER = "your-sonarqube-server" // Replace with your SonarQube server name
        SONARQUBE_TOKEN = credentials('sonarqube-token') // Replace with your SonarQube token credentials ID
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
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        stage('SonarQube Analysis') {
            environment {
                scannerHome = tool 'SonarQubeScanner'
            }
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=my_project_key" // Replace with your SonarQube project key
                }
            }
        }

        stage('Quality Gate') {
            steps {
                script {
                    def qg = waitForQualityGate()
                    if (qg.status != 'OK') {
                        error "Pipeline aborted due to quality gate failure: ${qg.status}"
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                cleanWs() // Ensure cleanWs is within a node context
            }
        }
    }
}
