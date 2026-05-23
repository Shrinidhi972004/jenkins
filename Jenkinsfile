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
                sh 'pip3 install -r requirements.txt'
            }
        }
        stage('Test') {
            steps {
                sh 'python3 -m pytest test_app.py -v'
            }
        }
        stage('Run') {
            steps {
                echo 'App is ready to deploy!'
            }
        }
    }
}