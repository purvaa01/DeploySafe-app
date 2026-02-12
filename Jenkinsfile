pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "purvaawankhede/deploysafe"
    }

    stages {
        stage('Checkout') {
        steps {
            git branch: 'main',
            url: https://github.com/purvaa01/DeploySafe-app.git
        }
        }

        stage('Build Docker Image')  {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE:$BUILD_NUMBER .'
                }
            }
        }

        stage('Login to Dockerhub') {
            steps {
                withCredentials([usernamePassword(
                credentialsId: 'dockerhub-credss',
                usernamevariable: 'DOCKER_USER',
                passwordvariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push $DOCKER_IMAGE:$BUILD_NUMBER'
            }
        }
    }

    post {
        success {
            echo "Image successfully pushed"
        }
        failure {
            echo "Pipeline failed"
        }
    }
}