pipeline {
    agent any
    tools {
        maven 'maven-3.9.6'
    }

    stages {
        stage('Git Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/m3bin/Hello.git']])
                echo 'Git Checkout Completed'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh '''mvn clean verify sonar:sonar -Dsonar.projectKey=cicd-full -Dsonar.projectName='cicd-full' -Dsonar.host.url=http://localhost:9000''' //port 9000 is default for sonar
                    echo 'SonarQube Analysis Completed'
                }
            }
        
        }
        stage('Copy to EC2') {
            steps {
                script {
                    sshagent(['ansible-admin']) {
                        sh "scp /Users/mebinmathew/.jenkins/workspace/cicd-complete-2/target/hello-0.0.1-SNAPSHOT.jar ansible-admin@3.87.154.46:/opt/docker"
                    }
                }
            }
        }
    }
}
