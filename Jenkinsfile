pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'heena002/hello-world-app'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
    }

    stages {
        
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Heena-dotcom/helloworld-pyhton-devops.git'
            }
        }

        

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE}:latest ."
                }
            }
        }

        stage('Run Unit Tests') {
            steps {
                sh 'python -m unittest discover -s tests'
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', DOCKER_CREDENTIALS_ID) {
                        sh "docker push ${DOCKER_IMAGE}:latest"
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check the logs for more details.'
        }
    }
}
