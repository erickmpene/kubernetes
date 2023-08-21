#### Install order

> 1. metallb-native.yaml
> 2. ipaddresspool.yml
> 3. deploy.yaml 

#### Compatibility

| Network addon | Compatible |
| ------------- | ---------- |
| Antrea  | Yes (Tested on version 1.4 and 1.5) |
|Calico | Mostly (see known issues) |
|Canal 	| Yes|
|Cilium | Yes|
|Flannel | Yes|
|Kube-ovn | Yes|
|Kube-router | Mostly (see known issues)|
|Weave Net | Mostly (see known issues)|

```sh
kubectl get svc -n ingress-nginx -o wide 
```