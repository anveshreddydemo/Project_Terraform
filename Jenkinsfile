pipeline {
    agent any

    parameters {
        choice(name: 'CHOICE', choices: ['apply', 'destroy'], description: 'Pick something')
    }

    stages {

        stage('init') {
            steps {
                sh 'terraform init'
            }
        }
        
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
