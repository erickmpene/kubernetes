### How upgrade worker

#### 1. drain node and check that the node has changed status
```sh
kubectl drain node-worker --ignore-daemonsets
kubectl get nodes
```
#### 2. Go to the node-worker and choose your version

##### 2.1 Debian :
To see available version 
```sh
apt show kubectl -a | grep 1.26 # this is an exemple
```
```sh
apt update 
KUBE_VERSION=1.26.1-00  # this is an exemple
apt-get install kubeadm=$KUBE_VERSION -y 
apt-mark hold kubeadm
apt-get install kubelet=$KUBE_VERSION kubectl=$KUBE_VERSION -y 
apt-mark hold kubelet kubectl
sudo systemctl daemon-reload
sudo systemctl restart kubelet
```

##### 2.2 CentOS
To see available version 
```sh
yum list --showduplicates kubeadm | grep 1.26  # this is an exemple
```
```sh
yum update
KUBE_VERSION=1.26.1-00  # this is an exemple
yum install -y kubelet-$KUBE_VERSION kubectl-$KUBE_VERSION --disableexcludes=kubernetes
sudo systemctl daemon-reload
sudo systemctl restart kubelet
```

