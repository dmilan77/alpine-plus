`docker run -it --rm dmilan/alpine-plus`
# kube
`kubectl run  -it --rm --restart='Never' --image=docker.io/dmilan/alpine-plus:latest alpine-plus`

```
# kubectl apply -f https://raw.githubusercontent.com/dmilan77/alpine-plus/master/pod-alpine-plus.yaml
# kubectl exec -it alpine-plus -- bash
# pod-alpine-plus.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: alpine-plus
  name: alpine-plus
spec:
  containers:
  - image: dmilan/alpine-plus
    name: alpine-plus
    command: ["tail","-f","/dev/null"]
```
