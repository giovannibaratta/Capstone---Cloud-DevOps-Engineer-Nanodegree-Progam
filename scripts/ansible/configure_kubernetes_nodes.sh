#! /bin/bash
# $1 -> virtual_env root path
# $2 -> kubernetes node private key path
# $3 -> hosted zone id of the load balancer
# $4 -> dns of the load balanced

if [ "$#" -ne 4 ]
then
    echo "Args: <virtual_env_dir> <k8s_private_key> <load_balancer_hosted_zone_id> <load_balancer_dns>"
    exit 1
fi

VIRTUAL_ENV_PATH="$1"

if [ ! -d $VIRTUAL_ENV_PATH ]
then
    echo "$VIRTUAL_ENV_PATH doesn't exist."
    exit 2
fi

K8S_PRIVATE_KEY="$2"

if [ ! -f $K8S_PRIVATE_KEY ]
then
    echo "$K8S_PRIVATE_KEY doesn't exist."
    exit 2
fi

LOAD_BALANCER_ZONE_ID="$3"
LOAD_BALANCER_DNS="$4"

source "$VIRTUAL_ENV_PATH/bin/activate"
cd "ansible"
ansible-playbook -i inventories/kubernetes_node_aws_ec2.yml \
    configure_kubernetes_nodes.yml \
    --private-key $K8S_PRIVATE_KEY \
    --extra-vars "{'loadBalancerZoneId':'$LOAD_BALANCER_ZONE_ID','loadBalancerDns':'$LOAD_BALANCER_DNS'}"

ANSIBLE_EXIT_CODE=$?

deactivate

exit $ANSIBLE_EXIT_CODE