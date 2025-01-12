pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'heena2325/hello-world-app'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
    }

    stages {
        stage('Install Python') {
            steps {
                script {
                    sh '''
                    apt update
                    apt install -y python3 python3-pip
                    python3 --version
                    pip3 --version
                    '''
                }
            }
        }
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Heena-dotcom/helloworld-pyhton-devops.git'
            }
        }
        stage('Run Unit Tests') {
            steps {
                sh 'python3 -m unittest discover -s tests'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                    sh 'docker build -t ${DOCKER_IMAGE} .'
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
