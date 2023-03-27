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

 post {
        failure {
            mail to: 'adresse-email@domaine.com',
            subject: 'Construction échouée sur dorsaf',
            body: "La construction a échoué sur la branche dorsaf. Veuillez consulter les logs pour plus d'informations."
        }
    }

       
}
