pipeline{
    agent any

    environment{
        RANDOM_STACK_ID = "${sh(script:'echo $BUILD_NUMBER', returnStdout: true).trim()}"
        K8S_PARAMS = "${sh(script:'sed s/DefaultUniqueID/$BUILD_NUMBER/ cloudformation/kubernetes_cluster.json', returnStdout: true).trim()}"
        ROOT_DIR = "${sh(script:'pwd', returnStdout: true).trim()}"
    }

    stages{
        stage("Print debug information"){
            steps{
                sh 'echo $RANDOM_STACK_ID'
                sh 'echo $K8S_PARAMS'
                sh 'echo $ROOT_DIR'
            }
        }

        stage("Linting"){
            steps{
                sh 'scripts/ci/lint_docker.sh'
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

        stage("Deploy stack to AWS"){
            steps{
                
                // update stack unique id
                sh 'echo $K8S_PARAMS | tee cloudformation/kubernetes_cluster.json'
                sh 'cat cloudformation/kubernetes_cluster.json'

                // create stack
                script{
                    def stackName = "capstone-kubernetes-${env.RANDOM_STACK_ID}"
                    def stackOutput = cfnUpdate(stack:stackName, file:'cloudformation/kubernetes_cluster.yml', paramsFile: 'cloudformation/kubernetes_cluster.json', create: true)
                    env.HOSTED_ZONE_ID = stackOutput.hostedZoneId
                    env.LB_DNS = stackOutput.loadBalancerDns
                }
                
                sh 'echo $HOSTED_ZONE_ID'
                sh 'echo $LB_DNS'
            }
        }

        stage("Configure stack"){
            steps{
                sh 'echo ~'
                sh 'whoami'
                sh "scripts/ansible/configure_kubernetes_nodes.sh /var/lib/jenkins/virtual_env /var/lib/jenkins/.ssh/microk8s_key $HOSTED_ZONE_ID $LB_DNS"
            }// on fail delete stack
        }
    }
}