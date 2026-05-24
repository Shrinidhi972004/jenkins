@Library('my-shared-library') _

pipeline {
    agent { label 'jenkins-agent' }

    environment {
        IMAGE_NAME = 'shrinidhiupadhyaya/flask-jenkins-demo'
    }

    stages {
        stage('Clone') {
            steps {
                echo 'Cloning the repo...'
                checkout scm
            }
        }
        stage('Install Dependencies') {
            steps {
                sh '''
                    python3 -m venv venv
                    venv/bin/pip install -r requirements.txt
                '''
            }
        }
        stage('Test') {
            steps {
                sh 'venv/bin/python -m pytest test_app.py -v'
            }
        }
        stage('Build Docker Image') {
            steps {
                buildImage(env.IMAGE_NAME)
            }
        }
        stage('Push to DockerHub') {
            steps {
                pushImage(env.IMAGE_NAME)
            }
        }
        stage('Run Container') {
            steps {
                runContainer(env.IMAGE_NAME)
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded! App is running at port 5000.'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}