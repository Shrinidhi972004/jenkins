pipeline {
    agent { label 'jenkins-agent' }

    environment {
        DOCKERHUB_CREDS = credentials('dockerhub-creds')
        IMAGE_NAME = 'shrinidhiupadhyaya/flask-jenkins-demo'
    }

    stages {
        stage('Clone') {
            steps {
                echo 'Cloninf thee repo'
                checkout scm
            }
        }
        stage('Install the dependencies') {
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
        stage('Build the docker image') {
            steps {
                sh '''
                    export DOCKER_BUILDKIT=1
                    docker build --cache-from $IMAGE_NAME:latest -t $IMAGE_NAME:latest .
                '''
            }
        }
        stage('Push the docker image') {
            steps {
                sh '''
                    echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
                    docker push $IMAGE_NAME:latest
                '''
            }
        }
        stage('Run container') {
            steps {
                sh '''
                    docker stop flask-demo || true
                    docker rm flask-demo || true
                    docker pull $IMAGE_NAME:latest
                    docker run -d -p 5000:5000 --name flask-demo $IMAGE_NAME:latest
                ''' 
            }
        }
    }
    post {
        success {
            echo 'Pipeline succeeded! App is running at port 5000'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}