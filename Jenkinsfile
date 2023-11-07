pipeline {
    agent {
        any {
            image 'node:20.9.0' 
            args '-p 3000:3000' 
        }
    }
    tools {nodejs "node"}
    stages {
        stage('Build') { 
            steps {
                sh 'npm install' 
            }
        }
        stage('Test') { 
            steps {
                sh './jenkins/scripts/test.sh' 
            }
        }
    }
}