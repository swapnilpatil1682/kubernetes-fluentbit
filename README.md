# Kubernetes Logging with Fluent Bit v0.13

Fluent Bit is a lightweight and extensible Log Processor that comes with full support for Kubernetes.
Fluent Bit must be deployed as a DaemonSet so that it will be available on every node of your Kubernetes cluster.

Fluentbit will export the metrics from all the pods and it will create a new index in elastic search instance with 
prefix <Your-project-name>-{{ env "ENVIRONMENT" }} following by the current date. 

In order to run fluentbit it will need RBAC authorization to it will first create Clusterrole and Clusterrolebinding. 
Please make sure the google account from which you are running has sufficient permission to create new Clusterrolebinding.

## Env variables for fluentbit  :

Envirnment variables are implented in deploy.sh file. 
Please make sure you have implemented correct values before running the script. 

##  Usage :

```
$ ./deploy.sh <environment>
```

## Fluentbit to grafana :

Once the index in elastic search is reflected you can import the elastic search index in grafana and create metrics.
