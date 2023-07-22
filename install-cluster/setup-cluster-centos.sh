
#! /bin/bash

echo "################## RUNNING CENTOS CONFIG #############"
sudo swapoff -a
sudo sed -i 's/\/swap/#\/swap/' /etc/fstab
sudo yum install -y wget nano tree curl git sudo 

echo "############IPTABLE CONFIGURATIONE ##############"
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
	sudo modprobe overlay
	sudo modprobe br_netfilter
	cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system

echo "########## CONTAINERD INSTALLATION AND CONFIGURATION ########################"
wget https://github.com/containerd/containerd/releases/download/v1.6.8/containerd-1.6.8-linux-amd64.tar.gz
sudo tar Cxzvf /usr/local containerd-1.6.8-linux-amd64.tar.gz
wget https://github.com/opencontainers/runc/releases/download/v1.1.3/runc.amd64
sudo install -m 755 runc.amd64 /usr/local/sbin/runc
wget https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz
sudo mkdir -p /opt/cni/bin
sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz
sudo mkdir /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
sudo curl -L https://raw.githubusercontent.com/containerd/containerd/main/containerd.service -o /etc/systemd/system/containerd.service
sudo systemctl daemon-reload
sudo systemctl enable --now containerd
sudo systemctl start containerd

######################################################

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF


sudo systemctl stop firewalld
sudo systemctl disable firewalld

sudo yum install -y kubelet kubeadm kubectl
sudo systemctl enable kubelet

	echo "############ INITIALIZING THE KUBERNETES CLUSTER  ###############"
	sudo kubeadm init --pod-network-cidr=10.244.0.0/16
	mkdir -p $HOME/.kube
	sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
	sudo chown $(id -u):$(id -g) $HOME/.kube/config
	echo "################# INSTALLATION OF PLUGINS FOR NETWORK MANAGEMENT IN THE CLUSTER  ######################"
	kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/tigera-operator.yaml
	kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/custom-resources.yaml
	kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/calico.yaml

	Kubectl get nodes 

	echo "############### TOKEN TO JOIN A NEW WORKER IN THE CLUSTER  ##############"
	kubeadm token create --print-join-command > join-node.txt
	echo "Below is the command to join a new worker to the Kubernetes cluster"
	cat join-node.txt 
