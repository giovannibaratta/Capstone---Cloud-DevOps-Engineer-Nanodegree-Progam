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
scripts/configure_ansible_controller.sh ~/.ssh/ansible_controller.pem
```
