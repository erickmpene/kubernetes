### I assume you have your cluster working. ```I advise you to make a snapshot of the state of your master-node``` before continuing on the commands that will follow below
---

#### 1. Type the following command :
```sh
kubectl edit configmaps kubeadm-config -n kube-system
```
##### Find the line : 
> ```clusterName: kubernetes``` as in the picture
If you have never changed the name of your cluster, it will be _kubernetes_
> Give whatever name you want. ```Letters must be lowercase```

#### 2. type the following command : 
```sh
cd ~/.kube 
```
```sh
nano config 
```
##### Modify the 4 words highlighted in yellow on the image with the name you have chosen for your cluster. Letters should always be lowercase.

#### 3. reboot your master-node
