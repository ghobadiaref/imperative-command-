############## install Agent #################
helm repo add gitlab https://charts.gitlab.io
helm upgrade --install k8s-cando gitlab/gitlab-agent     --namespace gitlab-agent-k8s-cando     --create-namespace     --set image.tag=v19.2.0     --set config.token=glagent-WDQP94_trFEpG8tH2cpRxm86MQpwOmMH.01.0w1pq06xm     --set config.kasAddress=wss://gitlab.cando.ac/-/kubernetes-agent/
#############################################
############# bootstrap gitlab #############
flux bootstrap gitlab \
  --token-auth \
  --hostname=gitlab.cando.ac \
  --owner=cando \
  --repository=manifests \
  --branch=main \
  --path=clusters/production \
  --ca-file=/usr/local/share/ca-certificates/gitlab.cando.ac.crt \ 
  --force 
##################################################
############## Checking ##########################
flux get sources git
flux get kustomizations
flux reconcile source git flux-system
k get gitrepositories.source.toolkit.fluxcd.io -n flux-system -o yaml
##################################################
