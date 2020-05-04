`docker run -it --rm dmilan/alpine-plus`
# kube
`kubectl run  -it --rm --restart='Never' --image=docker.io/dmilan/alpine-plus:latest alpine-plus`

```
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
