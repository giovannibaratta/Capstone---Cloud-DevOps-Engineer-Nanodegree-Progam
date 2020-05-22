Deploy steps:

```
cd cloudformation/infrastrucutre
../scripts/cloud-formation-helper.sh create capstoneNetwork network.yml
../scripts/cloud-formation-helper.sh create capstoneManagement jenkins_ansible.yml
../scripts/cloud-formation-helper.sh create capstoneKubernetes kubernetes_cluster.yml
```

Configuration steps:
```
cd cloudformation
scripts/configure_ansible_controller.sh ~/.ssh/ansible_controller.pem ~/.ssh/microk8s_key ~/Capstone---Cloud-DevOps-Engineer-Nanodegree-Progam/
scripts/configure_jenkins_node.sh ~/.ssh/jenkins_node.pem
scripts/launch_kubernetes_node_configuration.sh ~/.ssh/ansible_controller.pem
```

Connect to the jenkins node and login with the initial password stored in ~/jenkins_initial_password.