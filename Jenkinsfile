pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'  // Configura tus credenciales de Docker Hub
        REGISTRY = 'dunkelheitdll/docker-repo'
        IMAGE_NAME = 'hello-world-app'
    }

    stages {
        stage('Clonar Repositorio') {
            steps {
                git url: 'https://github.com/dunkelheitdll/PruebaTecnicaSMART.git'
            }
        }
        stage('Compilar Aplicación') {
            steps {
                sh 'python3 -m py_compile hello.py'
            }
        }

        stage('Ejecutar Pruebas Unitarias') {
            steps {
                sh 'pytest tests/'
            }
        }

        stage('Análisis de Código Estático') {
            steps {
                script {
                    sh 'sonar-scanner -Dsonar.projectKey=PruebaTecnicaSmart -Dsonar.sources=. -Dsonar.host.url=http://tusonarserver'
                }
            }
        }

        stage('Análisis de Vulnerabilidades') {
            steps {
                sh 'dependency-check.sh --project "PruebaTecnicaSmart" --scan .'
            }
        }

        stage('Construir y Publicar Imagen Docker') {
            steps {
                script {
                    docker.build("${REGISTRY}/${IMAGE_NAME}:${env.BUILD_NUMBER}").push()
                }
            }
        }

        stage('Despliegue en Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yaml'
            }
        }
    }

    post {
        always {
            mail to: 'danielsanabria89@gmail.com',
                 subject: "Pipeline finalizado: ${currentBuild.fullDisplayName}",
                 body: "Estado: ${currentBuild.currentResult}. Ver más detalles en ${env.BUILD_URL}"
        }
    }
}
