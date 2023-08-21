#### 1. apply the dashboard.yaml file
```sh
kubectl apply -f dashboard.yaml
```

#### 2. apply the dashboard.yaml file
```sh
kubectl apply -f service-account.yaml
```

#### 3. apply the dashboard.yaml file
```sh
kubectl apply -f clusterRoleBinding.yaml
```


#### 4. apply the dashboard.yaml file
```sh
kubectl apply -f secret.yaml
```

#### 5. recovery of the token for the connection on the dashboard
```sh
kubectl get secret myuser-secret -n kubernetes-dashboard  -o jsonpath="{.data.token}" | base64 --decode
```

