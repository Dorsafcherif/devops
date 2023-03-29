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
        stage('UNIT TEST'){
            steps {
                sh 'mvn test'
            } 
         stage('Scan') {
           steps {
             withSonarQubeEnv(installationName: 'devopsBack') {
               sh './mvnw clean org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0.2155:sonar'
             }
            }
 
        post {
            failure {
                mail to: 'dorsaf.cherif@esprit.tn',
                subject: 'Build failed',
                body: 'The build has failed. Please check Jenkins for details.'
            }
        }
    }
}
