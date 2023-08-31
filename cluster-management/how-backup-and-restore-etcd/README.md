### How to backup etcd
##### To make a backup of ETCD, you must absolutely install "etcdctl"
#### 1. you need to find the version of etcd installed on the Kubernetes cluster
I assume your master-node name is "master"
```sh
kubectl -n kube-system get pod/etcd-master -o=jsonpath='{$.spec.containers[:1].image}'
```
#### 2. run this script to install etcdctl with the good version of etcd
```sh

ETCD_VER=v3.5.6  # the value  you found in the previous point 

# choose either URL
GOOGLE_URL=https://storage.googleapis.com/etcd
GITHUB_URL=https://github.com/etcd-io/etcd/releases/download
DOWNLOAD_URL=${GOOGLE_URL}

rm -f /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz
rm -rf /tmp/etcd-download-test && mkdir -p /tmp/etcd-download-test

curl -L ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz -o /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz
tar xzvf /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz -C /tmp/etcd-download-test --strip-components=1
rm -f /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz

/tmp/etcd-download-test/etcd --version
/tmp/etcd-download-test/etcdctl version

ln -s /tmp/etcd-download-test/etcdctl /usr/bin/etcdctl

```
#### 3. Check etcdctl version
```sh
etcdctl version
``` 
#### 4. Backup etcd
The Kubernetes documentation gives us this command where you have to replace with the values ​​specific to your cluster
```sh
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cacert=<trusted-ca-file> --cert=<cert-file> --key=<key-file> snapshot save <backup-file-location>
```
> First, you need to find some value in the etcd's pod
```sh
kubectl describe pods etcd-master -n kube-system
```
> --endpoints => advertise-client-urls
> --cacert => trusted-ca-file
> --cert => cert-file
> --key => key-file


