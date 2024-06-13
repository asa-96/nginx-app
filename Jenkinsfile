pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = "nginx-app"
        DOCKER_IMAGE_TAG = "$BUILD_NUMBER"
        CHART_NAME = "my-app-chart"
        NEXUS_URL = "http://nexus.kloud.site"
        NEXUS_REPO = "helm-repo"
        NEXUS_CREDENTIAL_ID = "nexus-creds"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/asa-96/nginx-app.git'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}")
                }
            }
        }

        stage('Helm Chart') {
            steps {
                // Package Helm chart
                sh "helm package helm/${CHART_NAME} -d ."
            }
        }

        stage('Upload Chart to Nexus') {
            steps {
                script {
                    def helmChart = findFiles(glob: "${CHART_NAME}-*.tgz")[0]
                    sh """
                        curl -v --user ${NEXUS_CREDENTIAL_ID} --upload-file ${helmChart.path} ${NEXUS_URL}/repository/${NEXUS_REPO}/${helmChart.name}
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
