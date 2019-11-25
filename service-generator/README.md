## Updating the Dockerfile image
In case the docker image for the generator needs to be changed after modifying the
Dockerfile the image can be rebuilt using 
```
docker build -t tvd/modern-data-analytics-stack-generator:1.0 .
```