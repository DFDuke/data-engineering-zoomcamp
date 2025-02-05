Manually start kestra docker container

```bash
docker run --pull=always --rm -it -p 8080:8080 --user=root \
> -v /var/run/docker.sock:/var/run/docker.sock \
> -v /tmp:/tmp kestra/kestra:latest-full server local
```

Taxi Data
https://github.com/DataTalksClub/nyc-tlc-data/releases/tag/yellow
https://github.com/DataTalksClub/nyc-tlc-data/releases/tag/green

