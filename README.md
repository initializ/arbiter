## Arbiter

**_Check your clusters for deprecated APIs_**
(**`arbiter`**)\* is a simple tool to check whether you're using
any of these API versions in your cluster and therefore should upgrade your
workloads first, before upgrading your Kubernetes cluster.

This tool will be able to detect deprecated APIs depending on how you deploy
your resources, as we need the original manifest to be stored somewhere. In
particular following tools are supported:

- **file** - local manifests in YAML or JSON
- **kubectl** - uses the `kubectl.kubernetes.io/last-applied-configuration` annotation
- **Helm v3** - uses Helm manifests stored as Secrets or ConfigMaps directly in individual namespaces

[1]: https://kubernetes.io/blog/2022/11/18/upcoming-changes-in-kubernetes-1-26

## Install

 Download the [latest release](https://github.com/initializ/arbiter/releases)
 for your platform and unpack manually
  
 For MacOs:
 /usr/local/bin (unpack in this location)

## Usage

Configure Kubectl's current context to point to your cluster, `arbiter` will
look for the kube `.config` file in standard locations (you can point it to custom
location using the `-k` switch).

**`arbiter`** will collect resources from your cluster and report on found issues.

_Please note that you need to have sufficient permissions to read Secrets in the
cluster in order to use `Helm_` collectors.\*

```sh
$./arbiter
5:16AM INF >>>arbiter<<<
5:16AM INF version v1.0.0-alpha (Github : https://github.com/initializ/arbiter)
5:16AM INF Initializing collectors and retrieving data
5:16AM INF Target K8s version^ is 1.23.13
5:16AM INF Retrieved 5 resources from collector name=arbiter-Collector
5:16AM INF Retrieved 0 resources from collector name="Helm v3"
5:16AM INF Loaded ruleset name=deprecated-1-16.rego
5:16AM INF Loaded ruleset name=deprecated-1-22.rego
5:16AM INF Loaded ruleset name=deprecated-1-25.rego
5:16AM INF Loaded ruleset name=deprecated-1-26.rego
5:16AM INF Loaded ruleset name=deprecated-future.rego
__________________________________________________________________________________________
>>> Deprecated APIs removed in 1.26 <<<
------------------------------------------------------------------------------------------
KIND                      NAMESPACE   NAME         API_VERSION           REPLACE_WITH (SINCE)
HorizontalPodAutoscaler   default     php-apache   autoscaling/v2beta2   autoscaling/v2 (1.23.0)
```

### Arguments

You can list all the configuration options available using `--help` switch:

```sh
$./arbiter -h
Usage of ./arbiter:
  -A, --additional-annotation strings   additional annotations that should be checked to determine the last applied config
  -a, --additional-kind strings         additional kinds of resources to report in Kind.version.group.com format
  -c, --cluster                         enable Cluster collector (default true)
  -x, --context string                  kubeconfig context
  -e, --exit-error                      exit with non-zero code when issues are found
  -f, --filename strings                manifests to check, use - for stdin
      --helm3                           enable Helm v3 collector (default true)
  -k, --kubeconfig string               path to the kubeconfig file
  -l, --log-level string                set log level (trace, debug, info, warn, error, fatal, panic, disabled) (default "info")
  -o, --output string                   output format - [text|json] (default "text")
  -O, --output-file string              output file, use - for stdout (default "-")
  -t, --target-version string           target K8s version in SemVer format (autodetected by default)
  -v, --version                         prints the version of arbiter and exits
```
### Demo
<a href="https://asciinema.org/a/dPSu1toGxtJhy4xrjVvSYxq2D?autoplay=1"target="_blank"><img src="https://asciinema.org/a/dPSu1toGxtJhy4xrjVvSYxq2D.svg" /></a>


