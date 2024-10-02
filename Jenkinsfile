pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'mi-proyecto-angular:latest'
        REGISTRY = 'tu-registro-docker' // Por ejemplo, Docker Hub
        REGISTRY_CREDENTIALS = 'docker-hub-credenciales-id'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/tu-usuario/mi-proyecto-angular.git'
            }
        }

        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build --prod'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    docker.withRegistry("https://${env.REGISTRY}", "${env.REGISTRY_CREDENTIALS}") {
                        docker.image(DOCKER_IMAGE).push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                // Aquí puedes añadir pasos para desplegar tu contenedor, por ejemplo:
                sh 'docker stop mi-contenedor || true'
                sh 'docker rm mi-contenedor || true'
                sh 'docker run -d -p 80:80 --name mi-contenedor mi-proyecto-angular:latest'
            }
        }
    }

    post {
        success {
            echo 'Despliegue exitoso!'
        }
        failure {
            echo 'Fallo en el pipeline.'
        }
    }
}
