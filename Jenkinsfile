pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "my-demo-app"
        SONARQUBE_SERVER = "http://sonarqube-soau2w14.ldapowner.opsera.io/"
        SONARQUBE_TOKEN = credentials('sqp_b3521d171b02519caad93c4542bcacf39b4e30d4')
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
                    sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=test-proj-h"
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
            cleanWs()
        }
    }
}
