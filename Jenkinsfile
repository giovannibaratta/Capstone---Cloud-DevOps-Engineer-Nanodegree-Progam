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
                script{
                    docker_image = docker.build("giovannibaratta/capstone-project:latest")
                }
            }
        }

        stage("Push image"){
            steps{
                script{
                    docker.withRegistry('https://registry.hub.docker.com', "docker-credential"){
                        docker_image.push()
                    }
                }
            }
        }
    }
}