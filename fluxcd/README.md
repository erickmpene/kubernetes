To download the binary for amd64 architecture :


1. Installation :

=> wget https://github.com/fluxcd/flux/releases/download/1.25.4/fluxctl_linux_amd64
=> mv fluxctl_linux_amd64 /usr/local/bin/fluxctl
=> chmod 755 /usr/local/bin/fluxctl

2. Creation of a namespace :

/!\ This point is not mandatory. Personally I prefer to create a special namespace for my deployments with fluxcd

=> kubectl create namespace fluxcd
=> kubectl config set-context --current --namespace=fluxcd


3. fluxcd initialization

=> fluxctl install --git-email=my_email@domain.com --git-url=git@gitlab.com:xavki/testflux.git --git-path=workloads --namespace=fluxcd | kubectl apply -f -
