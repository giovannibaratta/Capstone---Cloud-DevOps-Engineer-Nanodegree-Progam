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

        stage("Security scan"){
            steps{
                aquaMicroscanner imageName: "giovannibaratta/capstone-project:latest", notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html'
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