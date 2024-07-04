pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "demo-image" // Replace with your Docker image name
        SONARQUBE_SERVER = "http://sonarqube-soau2w14.ldapowner.opsera.io/" // Replace with your SonarQube server name
        SONARQUBE_TOKEN = credentials('sqp_b3521d171b02519caad93c4542bcacf39b4e30d4') // Replace with your SonarQube token credentials ID
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
                    sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=test-proj-h" // Replace with your SonarQube project key
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
