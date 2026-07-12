pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "purvaawankhede/deploysafe-app"
        GITOPS_REPO = "https://github.com/purvaa01/Deploysafe-gitops"
        GITOPS_BRANCH = "main"
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

                    def shortCommit = sh(
                            script: "git rev-parse --short HEAD",
                            returnStdout: true
                    ).trim()

                    env.SHORT_COMMIT = shortCommit

                    sh """
                    docker build -t ${DOCKER_IMAGE}:${SHORT_COMMIT} .
                    docker tag ${DOCKER_IMAGE}:${SHORT_COMMIT} ${DOCKER_IMAGE}:latest
                    """
                }
            }
        }

        stage('Scan Docker Image') {
            steps {
                sh """
                trivy image --exit-code 0 --severity CRITICAL ${DOCKER_IMAGE}:${SHORT_COMMIT}
                """
            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-credss',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                )]) {

                    sh """
                    echo \$DOCKER_PASS | docker login \
                    -u \$DOCKER_USER \
                    --password-stdin
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh """
                docker push ${DOCKER_IMAGE}:${SHORT_COMMIT}
                docker push ${DOCKER_IMAGE}:latest
                """
            }
        }

        stage('Clone GitOps Repository') {
            steps {

                dir("gitops") {

                    git(
                            url: "${GITOPS_REPO}",
                            branch: "${GITOPS_BRANCH}",
                            credentialsId: "github-creds"
                    )

                }

            }
        }

        stage('Update Image Tag') {
            steps {

                dir("gitops") {

                    sh """
                    sed -i \
                    's|image: .*|image: ${DOCKER_IMAGE}:${SHORT_COMMIT}|' \
                    kubernetes/deployment.yaml

                    cat kubernetes/deployment.yaml
                    """

                }

            }
        }

        stage('Commit Changes') {
            steps {

                dir("gitops") {

                    sh """
                    git config user.name "Jenkins"
                    git config user.email "jenkins@deploysafe.local"

                    git add .

                    git commit -m "Update image to ${SHORT_COMMIT}" || echo "No changes to commit"
                    """

                }

            }
        }

        stage('Push Changes') {
            steps {

                dir("gitops") {

                    withCredentials([usernamePassword(
                            credentialsId: 'github-creds',
                            usernameVariable: 'GIT_USER',
                            passwordVariable: 'GIT_TOKEN'
                    )]) {

                        sh """
                       sh """
                        git push https://${GIT_USER}:${GIT_TOKEN}@github.com/purvaa01/Deploysafe-gitops.git main
                        """
                        """

                    }

                }

            }
        }
    }

    post {

        success {
            echo "GitOps update completed successfully."
        }

        failure {
            echo "Pipeline failed."
        }

        always {
            cleanWs()
        }

    }
}