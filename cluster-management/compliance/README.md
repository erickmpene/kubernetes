#### DEPLOY POLARIS with Helm

#### 1. Install helm on linux 
```sh
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

#### 2. Install Polaris Dashboard
```sh
helm repo add fairwinds-stable https://charts.fairwinds.com/stable
helm upgrade --install polaris fairwinds-stable/polaris --namespace polaris --create-namespace
```

#### 3. If yout want deploy an ingress 
```sh
kubectl apply -f ingress.yaml 
```

#### 4. install Polaris CLI

```sh
wget https://github.com/FairwindsOps/polaris/releases/download/8.4.0/polaris_linux_amd64.tar.gz
tar -zxvf polaris_linux_amd64.tar.gz
mv polaris /usr/bin
```

#### 5. Run Polaris CLI

choose your file or directory and run :
```sh
polaris audit --audit-path MyFile.yaml
```
#### Polaris Exit Codes for Audit Runs

| Code | Means |
| ---- | ----- |
|Exit 0|Successful exit code|
|Exit 1|Could not run audit, or application had a failure wwhile running|
|Exit 2| Unused|
|Exit 3|Exiting due to '--set-exit-code-on-danger' being set and at least one danger was found after an audit|
|Edit 4|Exiting due to '--set-exit-code-below-score' being set and the audit resulted in a score less than the minimum score value|