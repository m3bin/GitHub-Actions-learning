pipeline {
    agent any
    tools {
        maven 'maven-3.9.8'
    }

    stages {
        stage('Maven Build') {
            steps {
                // Run maven build
                sh 'mvn clean package -DskipTests'
                echo 'Maven build Completed'
            }
        }
    }
}
