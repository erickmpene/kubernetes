#### DEPLOY POLARIS with Helm

#### 1. Install helm on linux 
```sh
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

#### 2. Install Helm
```sh
helm repo add fairwinds-stable https://charts.fairwinds.com/stable
helm upgrade --install polaris fairwinds-stable/polaris --namespace polaris --create-namespace
```

#### 3. If yout want deploy an ingress 
```sh
kubectl apply -f ingress.yaml 
```