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
        stage('Build Docker image') {
            steps {
                script {
                    dockerfile = '''
                    FROM openjdk:11-jdk-alpine
                    WORKDIR /app
                    COPY target/tpAchatProject.jar /app/tpAchatProject.jar
                    EXPOSE 8089
                    CMD ["java", "-jar", "tpAchatProject.jar"]
                    '''
                    docker.withRegistry('', 'DOCKER_HUB_CREDENTIALS') {
                        docker.build('tpAchatProject', dockerfile: dockerfile)
                        docker.withRegistry('https://registry.docker.io', 'DOCKER_HUB_CREDENTIALS') {
                            docker.image('tpAchatProject').push()
                        }
                    }
                }
            }
        }
        stage('Deploy application') {
            steps {
                sh 'docker-compose up -d'
            }
        }
        stage('UNIT TEST') {
            steps {
                sh 'mvn test jacoco:report'
           }
        }
        stage('SonarQube analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                sh 'mvn sonar:sonar'
                }
            }
         }
    }
}
