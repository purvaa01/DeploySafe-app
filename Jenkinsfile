pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "purvaawankhede/deploysafe-app"
        KUBECONFIG = "/var/lib/jenkins/.kube/config"
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
                    trivy image --exit-code 0 --severity CRITICAL ${DOCKER_IMAGE}:${SHORT_COMMIT}
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

        stage('Detect Active environment') {
        steps {
        script {
        def active = sh(
        script: """
        kubectl get svc deploysafe-service \
        -n deploysafe \
        -o jsonpath='{.spec.selector.version}'

        """,
        returnStdout: true
        ).trim()

        if (active == "blue") {
            env.ACTIVE = "blue"
            env.INACTIVE = "green"
        }
        else {
        env.ACTIVE = "green"
        env.INACTIVE = "blue"
        }

        echo "Active environment: ${env.ACTIVE}"
        echo "Deploying to : ${env.INACTIVE}"
        }
        }
        }
        stage('Deploy to Inactive Environment') {
                    steps {
                        script {
                            sh """
                            kubectl set image deployment/deploysafe-${env.INACTIVE} \
                            deploysafe-container=${DOCKER_IMAGE}:${SHORT_COMMIT} \
                            -n deploysafe
                            """
                        }
                    }
                }
        stage('Deploy and Verify Rollout') {
            steps {
                script {
                    sh """
                    kubectl rollout status deployment/deploysafe-${env.INACTIVE} \
                    -n deploysafe \
                    --timeout=120s
                    """
                }
            }
        }

        stage('Switch Traffic') {
            steps {
                script {
                    sh """
                    echo "Switching traffic from ${env.ACTIVE} to ${env.INACTIVE}"
                    kubectl patch service deploysafe-service \
                    -n deploysafe \
                    -p '{"spec":{"selector":{"app":"deploysafe","version":"${env.INACTIVE}"}}}'
                    """
                }

                echo "Traffic successfully switched to ${env.INACTIVE}"
            }
        }


        stage('Verify Deployment') {
            steps {
                sh "./scripts/verify.sh ${ACTIVE}"
            }
        }

    }

//     post {
//         success {
//             slackSend(
//                 channel: "#all-deploysafe-ci",
//                 color: "good",
//                 message: "DeploySafe CI Passed! Image: ${DOCKER_IMAGE}:${SHORT_COMMIT}"
//             )
//         }
//         failure {
//             slackSend(
//                 channel: "#all-deploysafe-ci",
//                 color: "danger",
//                 message: "DeploySafe CI Failed! Check Jenkins logs."
//             )
//         }
//     }

}