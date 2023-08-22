##### 1. Prepare the NFS Server (CentOs)
```sh
yum install nfs-utils nfs-utils-lib
systemctl enable --now rpcbind
systemctl enable --now nfs
```
###### 1.1 Create the following folder and share it using nfs
```sh
mkdir /opt/dynamic-storage
chown -R nobody:nobody /opt/dynamic-storage
chmod 2770 /opt/dynamic-storage
```
###### 1.2 Add the following entries in /etc/exports file
```sh
vi /etc/exports
/opt/dynamic-storage 192.168.30.0/24(rw,sync,no_subtree_check)
```
Save and close the file.
###### 1.3 To make above changes into the effect, run
```sh
exportfs -a
systemctl restart nfs
systemctl status nfs
```
###### 1.4 On the worker nodes, install nfs-utils package using following yum command
```sh
yum install nfs-utils nfs-utils-lib
```

##### 2. Install and Configure NFS Client Provisioner (Master-node)
```sh
kubectl create ns nfs-provisioning
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner
helm repo update
helm install -n nfs-provisioning --create-namespace nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner --set nfs.server=192.168.1.139 --set nfs.path=/opt/dynamic-storage
```
##### 3. run the following command to retrieve the storage class
```sh
kubectl get storageclass
```

