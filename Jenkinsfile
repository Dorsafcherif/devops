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
        stage('Build Docker Image') {
            steps {
                script {
                  sh 'docker build -t devopshint/tpachatproject-1.0 .'
                }
            }
        }
        
        
    }
}
