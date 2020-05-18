pipeline{
    agent any

    stages{
        stage("Linting"){
            steps{
                sh 'scripts/lint_docker.sh'
            }
        }

        stage("Build docker image"){
            steps{
                sh 'scripts/build_docker.sh'
            }
        }
    }
}