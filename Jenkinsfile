pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "purvaawankhede/deploysafe-app"
        GITOPS_REPO = "https://github.com/purvaa01/Deploysafe-gitops"
        GITOPS_BRANCH = "main"

        SLACK_WEBHOOK = credentials('deploysafe-slack-webhook')
    }

    stages {
        stage('Notify Pipeline Start') {
            steps {
                sh """
        curl -X POST -H 'Content-type: application/json' \
        --data '{
            "text":"*DeploySafe Pipeline Started*\\n*Job:* ${JOB_NAME}\\n*Build:* #${BUILD_NUMBER}\\n*Branch:* ${GITOPS_BRANCH}"
        }' \
        ${SLACK_WEBHOOK}
        """
            }
        }

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
            kubernetes/rollout.yaml

            cat kubernetes/rollout.yaml
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

                        sh '''
                            git push https://$GIT_USER:$GIT_TOKEN@github.com/purvaa01/Deploysafe-gitops.git main
                        '''

                    }

                }

            }
        }
    }

    post {

        success {

            sh """
        curl -X POST -H 'Content-type: application/json' \
        --data '{
            "text":"*DeploySafe Pipeline Succeeded*\\n*Job:* ${JOB_NAME}\\n*Build:* #${BUILD_NUMBER}\\n*Image:* ${DOCKER_IMAGE}:${SHORT_COMMIT}\\n*Status:* SUCCESS\\n*Build URL:* ${BUILD_URL}"
        }' \
        ${SLACK_WEBHOOK}
        """

            echo "GitOps update completed successfully."
        }

        failure {

            sh """
        curl -X POST -H 'Content-type: application/json' \
        --data '{
            "text":"*DeploySafe Pipeline Failed*\\n*Job:* ${JOB_NAME}\\n*Build:* #${BUILD_NUMBER}\\n*Status:* FAILED\\n*Build URL:* ${BUILD_URL}"
        }' \
        ${SLACK_WEBHOOK}
        """

            echo "Pipeline failed."
        }

        always {
            cleanWs()
        }
    }
}