pipeline {
    agent any

    parameters {
        choice(name: 'CHOICE', choices: ['apply', 'destroy'], description: 'Pick something')
    }

    stages {

        stage('checking the terraform version') {
            steps {
                sh 'terraform -v'
            }
        }

        stage('init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('spaces') {
            steps {
                sh 'terraform fmt'
            }
        }

        stage('plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('apply') {
            steps {
                sh 'terraform ${params.CHOICE} --auto-approve '
            }
        }

        stage('destroy') {
            steps {
                sh 'terraform ${params.CHOICE} --auto-approve '
            }
        }
        
    }
}
