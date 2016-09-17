# fluentd-docker

Basic dockerfile for fluentd. Default entrypoint ensures proper ownership of required directores as root prior to starting fluentd as user `fluent` via `dosu` (so that host volumes can be mounted in without worrying about permissions and uids). 

Location of `fluent.conf` and `plugins` directory is configurable via the `FLUENTD_DATA_DIR` environment variable but defaults to `/home/fluent` if not set. Mount your conf file and plugins folder in this directory.

You can start fluentd with additional options by setting the `FLUENTD_OPT` environment variable.