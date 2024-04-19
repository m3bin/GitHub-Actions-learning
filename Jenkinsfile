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
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible-server', sshCredentials: [encryptedPassphrase: '{AQAAABAAAAAQ3fsMAagGz8BgWo/Hpd44pCJSPjYJmAI8iIttu/OWWec=}', key: '', keyPath: '', username: 'ansible-admin'], transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '/opt/docker/', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'cicd-complete-2/target/hello-0.0.1-SNAPSHOT.jar')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
    }
}
