# Nginx Unit - Alpine Linux

This is a work in-progress minimal Docker container running Alpine Linux along with [Nginx Unit](https://www.nginx.com/products/nginx-unit).

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
## Table of Contents

- [Example Application](#example-application)
  - [`type`](#type)
  - [`limits`](#limits)
  - [`processes`](#processes)
  - [`working_directory`](#working_directory)
  - [`user`](#user)
  - [`group`](#group)
  - [`environment`](#environment)
  - [`script`](#script)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


## Example Application

**See [Nginx Unit Configuration](http://unit.nginx.org/configuration) for the latest documentation.**


```json
{
  "listeners": {
    "*:3000": {
      "application": "api"
    }
  },
  "applications": {
    "api": {
      "type": "ruby",
      "limits": {
        "timeout": 10,
        "requests": 1000
      },
      "processes": 1,
      "working_directory": "/app/current",
      "user": "nobody",
      "group": "nobody",
      "environment": {
        "key": "value"
      },
      "script": "/app/current/simple/config.ru"
    }
  }
}

```

### `type`

Type of the application: `go`, `perl`, `php`, `python`, or `ruby`.

**Note: This Docker container only contains Ruby 2.5.1!**

### `limits`
_(optional)_

An object that accepts two integer options, `timeout` and `requests`. Their values restrict the life cycle of an application process.

| Option | Description |
| ------ | ----------- |
| `timeout` | Request timeout in seconds. If an application process exceeds this limit while processing a request, Unit terminates the process and returns an HTTP error to the client. |
| `requests` | Maximum number of requests Unit allows an application process to serve. If this limit is reached, Unit terminates and restarts the application process. This allows to mitigate application memory leaks or other issues that may accumulate over time. |


_For further details, see [Request Limits](http://unit.nginx.org/configuration/#configuration-proc-mgmt-lmts)._

### `processes`
_(optional)_

An integer or an object. Integer value configures a static number of application processes. Object accepts dynamic process management settings: `max`, `spare`, and `idle_timeout`.

| Option | Description |
| ------ | ----------- |
| `max`  | Maximum number of application processes that Unit will maintain (busy and idle). The default value is `1`. |
| `spare` | Minimum number of idle processes that Unit will reserve for the application when possible. When Unit starts an application, spare idle processes are launched. As requests arrive, Unit assigns them to existing idle processes and forks new idle ones to maintain the spare level if max permits. When processes complete requests and turn idle, Unit terminates extra ones after a timeout. The default value is 0. The value of spare cannot exceed max. |
| `idle_timeout` | Number of seconds for Unit to wait before it terminates an extra idle process, when the count of idle processes exceeds `spare`. The default value is `15`. |


_For further details, see [Process Management](http://unit.nginx.org/configuration/#configuration-proc-mgmt-prcs)._

### `working_directory`
_(optional)_

Working directory for the application. If not specified, the working directory of Unit daemon is used.

### `user`
_(optional)_

Username that runs the app process. If not specified, `nobody` is used.

### `group`
_(optional)_

Group name that runs the app process. If not specified, user’s primary group is used.

### `environment`
_(optional)_

Environment variables to be used by the application.

### `script`

Rack script path.
