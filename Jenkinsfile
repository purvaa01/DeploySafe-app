pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "purvaawankhede/deploysafe-app"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Get short commit SHA (7 characters)
                    def shortCommit = sh(
                        script: "git rev-parse --short HEAD",
                        returnStdout: true
                    ).trim()

                    env.SHORT_COMMIT = shortCommit

                    // Build image with commit SHA tag
                    sh "docker build -t ${DOCKER_IMAGE}:${SHORT_COMMIT} ."

                    // Tag same image as latest
                    sh "docker tag ${DOCKER_IMAGE}:${SHORT_COMMIT} ${DOCKER_IMAGE}:latest"
                }
            }
        }
        stage('Scan Docker Image') {
            steps {
                script {
                    sh """
                    trivy image --exit-code 1 --severity CRITICAL ${DOCKER_IMAGE}:${SHORT_COMMIT}
                    """
                }
            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credss',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                }
            }
        }

        stage('Push Image') {
            steps {
                sh "docker push ${DOCKER_IMAGE}:${SHORT_COMMIT}"
                sh "docker push ${DOCKER_IMAGE}:latest"
            }
        }
    }

    post {
        success {
            slackSend(
                channel: "#all-deploysafe-ci",
                color: "good",
                message: "✅ DeploySafe CI Passed! Image: ${DOCKER_IMAGE}:${SHORT_COMMIT}"
            )
        }
        failure {
            slackSend(
                channel: "#all-deploysafe-ci",
                color: "danger",
                message: "❌ DeploySafe CI Failed! Check Jenkins logs."
            )
        }
    }

}
