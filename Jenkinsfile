pipeline {
    agent any

    stages {
        stage('checkout') {
            steps {
                git branch: 'main', credentialsId: 'gitcred', url: 'https://github.com/anveshreddydemo/Project_Terraform.git'
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