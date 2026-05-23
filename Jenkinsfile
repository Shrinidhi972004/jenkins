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
        stage('Run') {
            steps {
                sh '''
                    venv/bin/python app.py &
                    sleep 2
                    curl http://localhost:5000
                    kill $(lsof -t -i:5000)
                '''
            }
        }
    }
}