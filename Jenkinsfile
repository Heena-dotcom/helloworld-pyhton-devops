pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'heena2325/hello-world-py-2'
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
        stage('Update image in deployment'){
            steps {
                sh '''
                rm -rf kubernertes
                git clone https://github.com/Heena-dotcom/kubernertes.git
                cd kubernertes/helloworld-python
                if ! grep -q "${DOCKER_IMAGE}" values.yaml; then
                    sed -i "s|repository:.*|repository: ${DOCKER_IMAGE}|g" values.yaml
                    git add values.yaml
                    git commit -m "Update image to ${DOCKER_IMAGE}"
                else
                    echo "Image is already up-to-date."
                fi
                '''
            }
        }
        stage('Push Changes') {
            steps {
                script {
                    // Push the changes to the repository
                    withCredentials([string(credentialsId: 'GitJenkinsToken', variable: 'GITHUB_TOKEN')]) {
                        sh '''
                        cd kubernertes
                        git remote set-url origin https://$GITHUB_TOKEN@github.com/Heena-dotcom/kubernertes.git
                        git push
                        '''
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
