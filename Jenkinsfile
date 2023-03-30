pipeline {
    agent any
    stages {
        stage('GIT') {
            steps {
                git url: 'https://github.com/Dorsafcherif/devops', branch: 'dorsaf'
            }
        }
        stage('MVN CLEAN') {
            steps {
                sh 'mvn clean'
            }
        }
        stage('MVN COMPILE') {
            steps {
                sh 'mvn compile'
            }
        }
        stage('UNIT TEST') {
            steps {
                sh 'mvn test'
            } 
        }
        stage('ScanSonar') {
            steps {
                withSonarQubeEnv(installationName: 'devopsBack') {
                    sh 'mvn clean org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0.2155:sonar -Dsonar.exclusions=**/*.java'
                }
            }
         }
        stage("Upload Artifact Nexus") {
            steps {
                nexusArtifactUploader(
                  nexusVersion: 'nexus3',
                  protocol: 'http',
                  nexusUrl: '192.168.44.133:8081/repository/mavenDevops/',
                  groupId: 'com.esprit.examen',
                  version: 'pom.1.0',
                  repository: 'mavenDevops',
                  credentialsId: 'nexus',
                  artifacts: [
                     [artifactId: 'pom.tpAchatProject',
                     classifier: '',
                     file: '/var/lib/jenkins/workspace/Spring IOC/target/tpAchatProject-1.0.jar',
                     type: 'jar']
                            ]
                )
             }
            }
        
    }
}
