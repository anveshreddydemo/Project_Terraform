pipeline {
    agent any

    parameters {
        choice(name: 'CHOICE', choices: ['apply', 'destroy'], description: 'Pick something')
    }

    stages {
        stage('Example') {
            steps {
                echo "You chose: ${params.CHOICE}"
            }
        }
        
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
    }
}
