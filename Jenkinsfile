pipeline {
    agent any

    stages {
        stage('checkout') {
            steps {
                git branch: 'main', credentialsId: 'gitcred', url: 'https://github.com/anveshreddydemo/Project_Terraform.git'
            }
        }

        stage('init') {
            steps {
                sh 'terraform init'
            }
        }
    }
}