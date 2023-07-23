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

/!\ You should know that I use a public repository, so I don't necessarily need an ssh key to synchronize fluxcd and my git repository. So I use https

=> fluxctl install --git-email=my_email@domain.com --git-url=https://github.com/erickmpene/kubernetes.git --git-path=fluxcd/my_workload --namespace=fluxcd | kubectl apply -f -

/!\ if you are using a private repository and you want to switch to ssh, you will need to create an authentication key with the following command:

=> fluxctl identity --k8s-fwd-ns fluxcd



For information visit this : 

=> https://github.com/fluxcd/flux

