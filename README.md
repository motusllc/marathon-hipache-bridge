# MarathonHipacheBridge

Syncs healthy hosts between Redis and Marathon
```
usage: Bridge.groovy [options]
 -i,--Interval <INTERVAL>     Interval in seconds at which the bridge
                              syncs Redis with Marathon
 -m,--MarathonUrl <URL>       Marathon url
 -P,--AppsPath <PATH>         Example: /v2/apps
 -r,--RedisHost <HOST:PORT>   indicate Redis host and port
```

To run on the command line:
```
./Bridge.groovy -i 5 -m http://mesosmaster1-staging.motus.com:8080/ -P /v2/apps -r redirect1-staging.crsinc.com:6379
```

To run in a docker container:
```
docker build --rm -t <tag> .
docker run <tag> ./Bridge.groovy -i 5 -m http://mesosmaster1-staging.motus.com:8080/ -P /v2/apps -r redirect1-staging.crsinc.com:6379
```