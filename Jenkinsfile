pipeline {
    agent any
    options {
      buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('docker-docherHub')
  }
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
                  sh 'mvn package'   
                  sh 'docker build -t docker/devops:latest --build-arg JAR_FILE=target/tpAchatProject-1.0.jar .'
            }
        }
        stage('Login') {
            steps {
       
            sh 'echo Dorsaf123. | docker login -u dorsaf99 --password-stdin'
        }
      }
 
       stage('Push') {
           steps {
                sh 'docker push docker/devops:latest'
      }
    }
        
    }
 post {
    always {
      sh 'docker logout'
    }
 failure {
            mail to: 'dorsaf.cherif@esprit.tn',
                subject: 'Erreur dans le pipeline',
                body: "Le pipeline  a échoué. Veuillez vérifier la source du pipeline."
        }
  }
}
