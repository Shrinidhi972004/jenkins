pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                echo 'Cloning repo...'
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
                sh '''
                    export DOCKER_BUILDKIT=1
                    docker build --cache-from flask-jenkins-demo:latest -t flask-jenkins-demo:latest .
                '''
            }
        }
        stage('Run Container') {
            steps {
                sh '''
                    docker stop flask-demo || true
                    docker rm flask-demo || true
                    docker run -d -p 5000:5000 --name flask-demo flask-jenkins-demo:latest
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded! App is running at port 5000.'
        }
        failure {
            echo 'Pipeline failed! Check the logs above.'
        }
    }
}