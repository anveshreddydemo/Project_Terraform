pipeline {
    agent any

    parameters {
        choice(name: 'CHOICE', choices: ['apply', 'destroy'], description: 'Pick something')
    }

    stages {

        stage('aws version') {
            steps {
                sh '''
                aws --version
                aws sts get-caller-identity '''
            }
        } 

        stage('checking the instances') {
            steps {
                sh 'aws ec2 describe-instances'
            }
        } 
        
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
