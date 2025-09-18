pipeline {
    agent any

    parameters {
        choice(name: 'CHOICE', choices: ['apply', 'destroy'], description: 'Pick something')
    }

    stages {
        stage('destroy') {
            steps {
                sh "terraform ${params.CHOICE} --auto-approve"
            }
        }

    }
    post {
    always {
        cleanWs()
    }
}


        
}
