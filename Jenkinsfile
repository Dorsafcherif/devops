pipeline {
    agent any
    stages {
        stage('GIT') {
            steps {
                git url: 'https://github.com/Dorsafcherif/devops', branch: 'dorsaf'
            }
        }
        stage('Build application') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('SonarQube analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar -Dsonar.host.url=http://localhost:9000'
                }
            }
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
    }
}
