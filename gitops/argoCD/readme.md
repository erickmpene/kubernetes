### Installing ArgoCD (Linux Centos)
#### 1. Download latest version
```sh
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

#### 2. Download and install argoCD CLI
```sh
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm -fr argocd-linux-amd64
```

#### 3. Expose The Argo CD API Server with Port-Forwarding
```sh
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
#### 4. Access The Argo CD API Server
Login : admin
The initial password for the admin account is auto-generated and stored as clear text in the field password in a secret named argocd-initial-admin-secret in your Argo CD installation namespace. You can simply retrieve this password using the argocd CLI :
```sh
argocd admin initial-password -n argocd
```

#### 5. Change password
Change the password using the command:
```sh
argocd account update-password
```
#### 6. Connect to ArgoCD from Argo CLI
> First i look for the service that "argocd-server" exposes, then i get its IP address
```sh
kubectl get service -n argocd
```

> In my case de IP address of my service is 10.109.50.122 

```sh
argocd login 10.109.50.122
```
Username: admin
Password: # enter the password that you recovered in point 4

_'admin:login' logged in successfully_
_Context '10.109.50.122' updated_


#### 7. Add new Cluster to ArgoCD
On command line :
```sh

```