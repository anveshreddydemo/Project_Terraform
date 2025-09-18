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
    }
}
