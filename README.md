# MarathonHipacheBridge

Syncs healthy tasks between [Hipache](https://github.com/hipache/hipache) and [Marathon](https://mesosphere.github.io/marathon/). 

The assumption is that you are running applications in Marathon and you'd like the tasks to be registered in Hipache as backends for a given URL frontend.  This bridge application checks Marathon periodically and ensures that Hipache's list of backends matches the list of healthy tasks for a given application.  

### Usage
```
usage: Bridge.groovy [options]
 -i,--Interval <INTERVAL>     Interval in seconds at which the bridge
                              syncs Hipache with Marathon
 -m,--MarathonUrl <URL>       Marathon url
 -P,--AppsPath <PATH>         Example: /v2/apps
 -r,--RedisHost <HOST:PORT>   indicate Redis host and port
```

To run on the command line:
```
./Bridge.groovy -i 5 -m http://mesosmaster1.example.com:8080/ -P /v2/apps -r redis.example.com:6379
```

To run in a docker container:
```
docker build --rm -t <tag> .
docker run <tag> ./Bridge.groovy -i 5 -m http://mesosmaster1.example.com:8080/ -P /v2/apps -r redis.example.com:6379
```

### Marathon Configuration
Marathon is configured to work with the bridge by adding a label with the key **hipacheFrontend** under each app.  The value of the label should be a list of Hipache front ends separated by commas with no spaces.  For example:

```
    "labels": {
        "hipacheFrontend": "www.example.com,app.example.com"
    }
```

A label such as above would inject two keys into Redis at the first sync: **frontend:www.example.com** and **frontend:app.example.com**.  The Bridge ensures that each Redis frontend key will subsequently be configured with the appropriate host names and ports of the running tasks.  