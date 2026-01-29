pipeline {
    agent any

    environment {
        // Change these to your actual Docker Hub details
        DOCKER_USER = "kalam1shadow"
        IMAGE_NAME  = "webstatus"
        REGISTRY_ID = "Docker"
    }

    stages {
        stage('Build') {
            steps {
                script {
                    // Builds the image using the Dockerfile we just wrote
                    customImage = docker.build("${DOCKER_USER}/${IMAGE_NAME}:${env.BUILD_ID}")
                }
            }
        }

        stage('Test Run') {
            steps {
                script {
                    // This runs the container, checks if port 80 is responsive, then stops it
                    customImage.withRun('-p 8081:80') { c ->
                        sh "sleep 5" // Wait for Nginx to initialize
                        sh "curl http://localhost:8081 | grep 'Online'"
                    }
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    docker.withRegistry('', REGISTRY_ID) {
                        customImage.push("${env.BUILD_ID}")
                        customImage.push("latest")
                    }
                }
            }
        }

        stage('Cleanup') {
            steps {
                // Removes the local image to save disk space on your HP Victus
                sh "docker rmi ${DOCKER_USER}/${IMAGE_NAME}:${env.BUILD_ID}"
                sh "docker rmi ${DOCKER_USER}/${IMAGE_NAME}:latest"
            }
        }
    }
}
