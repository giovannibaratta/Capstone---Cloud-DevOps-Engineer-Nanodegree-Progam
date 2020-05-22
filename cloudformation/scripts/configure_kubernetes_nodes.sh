cd "repo/cloudformation/ansible"

ansible-playbook -i inventories/kubernetes_node_aws_ec2.yml \
    configure_kubernetes_nodes.yml \
    --private-key "~/.ssh/instance_private_key.pem"