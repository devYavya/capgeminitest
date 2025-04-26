pipeline {
    agent any

    environment {
        IMAGE_NAME = 'devyavya/capgeminitest'
        RAILS_ENV = 'test'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/devYavya/capgeminitest.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Run Tests in Docker') {
            steps {
                script {
                    dockerImage.inside("-e RAILS_ENV=test") {
                        sh "bundle exec rails db:create db:migrate RAILS_ENV=test"
                        sh "bundle exec rails test"
                    }
                }
            }
        }

        stage('Push to DockerHub') {
            when {
                branch 'main' 
            }
            steps {
                withDockerRegistry(credentialsId: 'dockerhub-credentials', url: '') {
                    script {
                        dockerImage.push('latest')
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Build and tests succeeded!'
        }
        failure {
            echo 'Build or tests failed.'
        }
    }
}
