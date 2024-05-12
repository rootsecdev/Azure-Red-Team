# Kubernetes Exploit Hub

## Description
These are a collection of methods and tools I've found useful on pentesting Kubernetes Clusters. 

References to setup an AKS Cluster in Azure:
https://docs.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-portal?tabs=azure-cli

### Microsoft Recon

If you have some Microsoft creds that have access to an AKS cluster

Login:
```
az login
```

Configure kubectl to connect to your Kubernetes cluster:
```
az aks get-credentials --resource-group myResourceGroup --name myAKSCluster
```

If you are on a administrative VM with WSL or linux box. You can and should loot the .kube directory!

### Discovery and Enumeration
**Discovery with nmap (Sample with IP Address):**

```
nmap -sC -sV -p- -oA Kubernetes1 10.10.197.28
```

Pay attention to DNS names from NMAP scan outputs as they can give away that you are working with a Kubernetes environment when you have a cluster operating on a non standard port. 

**Discovering Kubernetes Clusters with Kube Hunter:**

Note: You can do single IP addresses or entire subnet ranges with this tool. If on a penetration testing engagement this should be helpful for fingerprinting kubernetes clusters and developing a quick win on potential pod misconfigurations. 

Software URL:https://github.com/aquasecurity/kube-hunter

Installation:
```
sudo pip3 install kube-hunter
```

Run Kube hunter:

```
kube-hunter
```

### Initial Exploitation

After Gaining access to a cluster. Usually by misconfiguration with the application that it is hosting. PHP, Grafana, etc.

**Service Account Token Location**
```
/var/run/secrets/kubernetes.io/serviceaccount/token
```

Dropping out token and exporting it with your current terminal session:
```
cat /var/run/secrets/kubernetes.io/serviceaccount/token
```

```
export TOKEN={TOKEN}
```

**Checking your permissions with the current token that you have(remote command):**
```
kubectl --server https://serverip:port --token=$TOKEN auth can-i --list
```

If cluster is running a self sign certificate then add insecure tls to your command:
```
kubectl --server https://serverip:port --token=$TOKEN --insecure-skip-tls-verify auth can-i --list
```
**Checking your permissions with the current token that you have (Local Commands):**

This is basically the same thing as above with the exception that you are dropping the --server command

ProTip: If you need to do file transfers to a pod. Its very possible you may be in a pod without wget or curl commands. Normally I am only transfer kubectl and a poisoned pod of some sort. Pwncat-cs has been an excellent choice not only from an upload standpoint but you will have a nice full tty session to work with as well. 

Github: https://github.com/calebstewart/pwncat

Installation:

```
pip install pwncat-cs
```

Install with venv (What I would recommend so you don't impact other projects with python version dependicies on your attack box.) 

```
python3 -m venv pwncat-env
source pwncat-env/bin/activate
pip install pwncat-cs
```

Check Permissions:
```
kubectl --token=$TOKEN auth can-i --list
```

**Checking out what PODS are running**
(Remote):
```
kubectl get pods --server https://serverip:port --token=$TOKEN --insecure-skip-tls-verify
```

(Local):
```
kubectl get pods --token=$TOKEN
```
**Get POD Configurations**

This is useful if you need to produce an image of the same type with a posioned pod for later. 

(Local):
```
./kubectl get pod php-deploy-6d998f68b9-wlslz --token=$TOKEN -o yaml
```
**Hunting for API's and getting secrets from them**

Get API's

(Remote):
```
kubectl api-resources --server https://ip:port --token=$TOKEN --insecure-skip-tls-verify
```

(Local):
```
kubectl api-resources --token=$TOKEN --insecure-skip-tls-verify
```

Get namespaces from within API Example is through a API called "secrets":

(Remote):
```
kubectl --server https://10.10.103.214:6443 --token=$TOKEN --insecure-skip-tls-verify get secrets --all-namespaces
```

(Local):
```
kubectl --token=$TOKEN secrets --all-namespaces
```

Pull up YAML output of name/namespaces(example for flag3):

```
kubectl --server https://10.10.103.214:6443 --token=$TOKEN --insecure-skip-tls-verify get secrets flag3 -n kube-system -o yaml
```

### Escaping with bad pods

URL Reference: https://github.com/BishopFox/badPods

**Tips and Tricks with bad pods:**

If Isolated from internet include this in your yaml config:

```
imagePullPolicy: IfNotPresent
```

Always make note of your mount point when breaking out from a pod. This will be in your yaml config of your bad pod. For example this will make your mount point at /host:

```
volumeMounts:
    - mountPath: /host
      name: noderoot
```
## Penetration Testing Resources on Kubernetes

**Try Hack Me Rooms:**

Insekube: https://tryhackme.com/room/insekube

Frank & Herby make an app: https://tryhackme.com/room/frankandherby

Frank and Herby try again: https://tryhackme.com/room/frankandherbytryagain

PalsForLife: https://tryhackme.com/room/palsforlife

Kubernetes for Everyone: https://tryhackme.com/room/kubernetesforyouly

Island Orchestration: https://tryhackme.com/room/islandorchestration

**Hack The Box rooms**

Unobtainium: https://app.hackthebox.com/machines/Unobtainium

**References**

What is The Kubenomicon?: https://kubenomicon.com/
