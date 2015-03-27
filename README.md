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
### Marathon Configuration
Marathon is configured to work with the bridge by adding a label with the key **hipacheFrontend** under each app.  The value of the label should be a list of Redis keys separated by commas with no spaces.  For example:
```
        "labels": {
            "hipacheFrontend": "app-staging.motus.com,legacy.service-staging.motus.com"
        }
```
A label such as above would inject two keys into Redis at the first sync: **frontend:app-staging.motus.com** and **frontend:legacy.service-staging.motus.com**.  The Bridge ensures that each Redis frontend key will subsequently be configured with the appropriate host names and ports.