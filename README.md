# Spring-Boot-Graal-VM-Example

## Building from Source

### Docker build

#### Build

```shell
docker build --no-cache --progress=plain -t graal-vm-demo:0.0.1 -t graal-vm-demo:latest . 
```

#### Run

```shell
docker run -e SPRING_PROFILES_ACTIVE=local -p8080:8080 graal-vm-demo:0.0.1
```