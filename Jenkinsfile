pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                git 'https://github.com/Dorsafcherif/devops', branch: 'dorsaf'
                sh 'mvn clean package'
            }
        }
    }
    post {
        failure {
            mail to: 'dorsaf.cherif@esprit.tn',
            subject: 'Construction échouée sur dorsaf',
            body: "La construction a échoué sur la branche dorsaf. Veuillez consulter les logs pour plus d'informations."
        }
    }
}
