# I explain here how to create an authentication certificate on a Kubernetes cluster
---
### _Some guidelines_
> My_UserName = toto
> Group = operation
> Organization = mydomain.com
> my_server = the server on which kubectl is installed and on which the new user will access the kubernetes cluster

```/!\ Kubectl must be installed on the server /!\ ```

### 1. We create a folder to store our certificates.
```sh
mkdir -p  ~/.kube/certificate
cd ~/.kube/certificate
```
### 2. Generation of a key that will be used to create a certificate request
```sh
openssl genrsa -out toto.key 2048
```
You will have a toto.key file  

### 3. certificate request
```sh
openssl req -new -key toto.key -out toto.csr -subj "/CN=toto/O=operation/O=mydomain.local"
```
You will have a toto.csr file
You will need to copy the toto.csr file to the master-node in the directory you want
For the example, I will copy the file into the "/tmp" directory of the master-node
```sh 
scp toto.csr myuser@master-node:/tmp 
```
### 4. On the master node
```sh
sudo openssl x509 -req -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -days 730 -in /tmp/toto.csr -out toto.crt                                         
```
At this point, you will have the toto.crt file. 
You need to copy the ```toto.crt ``` file you just generated and the ```/etc/kubernetes/pki/ca.crt``` file to the server where you generated the certificates.
```sh
scp /tmp/toto.crt myuser@my_server:~/.kube/certificate
```
```sh
scp /etc/kubernetes/pki/ca.crt myuser@my_server:~/.kube/certificate
```

### 5. Setting up User configs with kubectl
```sh
cd ~/.kube
```
```sh
kubectl config set-credentials toto --client-certificate=~/.kube/certificate/toto.crt --client-key=~/.kube/certificate/toto.key
```
```sh
kubectl config get-contexts
```
```sh
kubectl config set-context toto-kubernetes --cluster=kubernetes  --user=toto --namespace=default
```
```sh
Kubectl config view
kubectl config set-context --current --namespace=default
```
Here we will provide the correct ip address of the master node
```sh 
kubectl config set-cluster kubernetes --server=https://master-node:6443 --certificate-authority=~/.kube/certificate/ca.crt
``` 

### _Everything is ready on the certificate side. All that remains is to create and grant rights to the new user on the master node. Please use yaml files for entitlement creation. You can adapt the rights according to your situation_


