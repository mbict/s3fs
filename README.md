# S3FS
Mount a s3 bucket as a file system in docker.

### Running from the commandline
To run the container from the docker, issue the following command
```
docker run --rm -it --privileged -e ACCESS_KEY_ID={<your_space_access_key>} -e SECRET_ACCESS_KEY={<your_spaces_secret_access_key>} -e BUCKET={<spaces_bucket_name>} -e REGION=ams3 -e ENDPOINT=https://ams3.digitaloceanspaces.com  mbict/s3fs  
```

### Example for kubernetes
I used this to have some files shared between nodes in kubernetes.

Check the kubernetes directory with the files


Create a new namespace
```
kubectl create namespace s3
```

Create a new secret for the access credentials
```
kubectl create secret generic s3-secrets \
      --namespace=s3 \
      --from-literal=ACCESS_KEY_ID={<YOUR_S3_KEY_ID>} \
      --from-literal=SECRET_ACCESS_KEY={<YOUR_S3_ACCESS_KEY>}  
```

Change and set the configmap
```
kubectl apply -f configmap.yml
```

And finally start the daemonset on all nodes
```
kubectl apply -f daemonset.yml
```

For a simple example mounting a directory inside the s3 space spin up the `examplepod.yml` container.
