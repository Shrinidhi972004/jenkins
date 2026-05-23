pipeline {
	agent any 
	stages {
		stage('Clone') {
			steps {
				echo 'Cloning the repo'
				checkout scm
			}
		}
		stage('Install Dependencies') {
			steps {
				sh 'pip install -r requirements.txt'
			}
		}
		stage('Test') {
			steps {
				sh 'python3 -m pytest test_app.py -v'
			}
		}
		stage('Run') {
			steps {
				echo 'App id ready to deploy'
			}
		}
	}
}
