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
        stage('Copy artifact to EC2') {
            steps {
                // Copy jar file to EC2 instance
                sshPublisher(
                    publishers: [
                        sshPublisherDesc(
                            configName: 'ansible-server',
                            transfers: [
                                sshTransfer(
                                    cleanRemote: false,
                                    excludes: '',
                                    execCommand: '',
                                    execTimeout: 120000,
                                    flatten: false,
                                    makeEmptyDirs: false,
                                    noDefaultExcludes: false,
                                    patternSeparator: '[, ]+',
                                    remoteDirectory: '//opt//docker',
                                    remoteDirectorySDF: false,
                                    removePrefix: 'target',
                                    sourceFiles: 'target/*.jar'
                                )
                            ],
                            usePromotionTimestamp: false,
                            useWorkspaceInPromotion: false,
                            verbose: false
                        )
                    ]
                )
                echo 'Copying Jar to EC2 Completed'
            }
        }
    }
}
