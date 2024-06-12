# Thanosmark

Thanos + benchmark. Simple, experimental setups for stress testing and benchmarking various aspects of Thanos.

## Running

Ensure you have kubectl access to a cluster. You can customize what namespace you want to deploy scenarios in by setting `NAMESPACE` in `.env` file.

Most Thanos components need access to an objstore storage bucket. To get a minio instance up and running,
```bash
make objstore
```

Some scenarios may need access to pre-existing data in objstore. To fill objstore bucket with some data, run,
```bash
make block-data
```
You can customize the type and range of data by using `PROFILE` and `MAXTIME`. The supported profile are defined [here](https://github.com/thanos-io/thanosbench/blob/master/pkg/blockgen/profiles.go#L27).

Next, explore the Makefile and run scenario you need to run. You can choose to customize aspects of these scenarios with the `.env` file.
