# TIBCO Platform Integration Applications Capabilities helm charts

## Overview

This directory contains the recipes to build and examples to use the [**TIBCO Platform Intgration Applications Capabilties**](https://github.com/sasahoo-tibco/tp-integration) Helm charts:

- [bwce provisioner](https://github.com/sasahoo-tibco/tp-integration/blob/main/helm/charts/bwprovisioner/README.md): TIBCO Platform Integration Application: BWCE provisioner helm chart.
- [artifact manager](https://github.com/sasahoo-tibco/tp-integration/blob/main/helm/charts/artifactmanager/README.md): TIBCO Platform Integration Application: Artifact Manager helm chart.
- [api server](https://github.com/sasahoo-tibco/tp-integration/blob/main/helm/charts/apiserver/README.md): TIBCO Platform Integration Application: API Server  helm chart.

See the respective README files for details and usage examples.

**Note**: There are other recipes in the `charts` directory not listed here.
Those chart will be added here for new capabilities recipe.

## Prerequisites

- Kubernetes 1.23+, a working kubernetes cluster from a ([certified k8s distro](https://www.cncf.io/certification/software-conformance/)).
- Helm 3+, for building and deploying the charts.

## Building the charts

You can package the provided charts, one by one, by following these steps from each of the provided charts directories:

1. Go to the chart directory. For example:
    ```bash
    cd <this-repo>/helm/chart/<tibco-platform-integration-capabilities-chart>
    ```

2. Update the chart dependencies:
    ```bash
    helm dependency update .
    ```

3. Package the chart:
    ```bash
    helm package . -d <helm-charts-destination-path>
    ```

Repeat for each of the charts.

## Recipe for BWCE Capabilities

- [BWCE Capabilities](https://github.com/sasahoo-tibco/tp-integration/blob/main/helm/recipe/bwce-capabilities.yaml): TIBCO Platform Integration bwce capabilties recipe.
#### Example of the recipe
```bash
  helmCharts:
    - name: bwprovisioner
      namespace: ${NAMESPACE}
      repository:
        git:
          host: https://github.com/sasahoo-tibco/tp-integration.git
          path: /helm/charts/bwprovisioner
          branch: main
      values:
        - content: |
            global:
              bwprovisioner:
                data:
                  namspace: ${NAMESPACE}
                image:
                  registry: 664529841144.dkr.ecr.us-west-2.amazonaws.com
                  tag: 38-m1-ext
            ingress:
              annotations:
                haproxy.org/cors-enable: "true"
                haproxy.org/load-balance: leastconn
                haproxy.org/src-ip-header: X-Real-IP
                haproxy.org/timeout-http-request: 600s
                ingress.kubernetes.io/rewrite-target: /
                meta.helm.sh/release-name: bwprovisioner
                meta.helm.sh/release-namespace: ${NAMESPACE}
              enabled: true
              hostsOverride: false
            volumes:
              bwprovisioner:
                persistentVolumeClaim:
                  create: true
                  storageClassName: ${STORAGE_CLASS_NAME}
      flags:
        install: true
        createNamespace: true
        dependencyUpdate: true
    - name: artifactmanager
      namespace: ${NAMESPACE}
      repository:
        git:
          host: https://github.com/sasahoo-tibco/tp-integration.git
          path: /helm/charts/artifactmanager
          branch: main
      values:
        - content: |
            global:
              artifactmanager:
                data:
                  namspace: ${NAMESPACE}
                image:
                  registry: 664529841144.dkr.ecr.us-west-2.amazonaws.com
                  tag: 11-m1-ext
            ingress:
              annotations:
                haproxy.org/cors-enable: "true"
                haproxy.org/load-balance: leastconn
                haproxy.org/src-ip-header: X-Real-IP
                haproxy.org/timeout-http-request: 600s
                ingress.kubernetes.io/rewrite-target: /
                meta.helm.sh/release-name: artifactmanager
                meta.helm.sh/release-namespace: ${NAMESPACE}
              enabled: true
              hostsOverride: false
            volumes:
              artifactmanager:
                persistentVolumeClaim:
                  create: true
                  storageClassName: ${STORAGE_CLASS_NAME}
      flags:
        install: true
        createNamespace: true
        dependencyUpdate: true
    - name: apiserver
      namespace: ${NAMESPACE}
      repository:
        git:
          host: https://github.com/sasahoo-tibco/tp-integration.git
          path: /helm/charts/apiserver
          branch: main
      values:
        - content: |
            global:
              apiserver:
                data:
                  namspace: ${NAMESPACE}
                image:
                  registry: 664529841144.dkr.ecr.us-west-2.amazonaws.com
                  tag: 7-m1-ext
            ingress:
              annotations:
                haproxy.org/cors-enable: "true"
                haproxy.org/load-balance: leastconn
                haproxy.org/src-ip-header: X-Real-IP
                haproxy.org/timeout-http-request: 600s
                ingress.kubernetes.io/rewrite-target: /
                meta.helm.sh/release-name: apiserver
                meta.helm.sh/release-namespace: ${NAMESPACE}
              enabled: true
              hostsOverride: false
            ingressExternal:
              annotations:
                haproxy.org/cors-enable: "true"
                haproxy.org/load-balance: leastconn
                haproxy.org/src-ip-header: X-Real-IP
                haproxy.org/timeout-http-request: 600s
                ingress.kubernetes.io/rewrite-target: /
                meta.helm.sh/release-name: apiserver
                meta.helm.sh/release-namespace: ${NAMESPACE}
              enabled: true
              className: ${INGRESS_CLASS_NAME}
              hosts:
                - host: ${EXTERNAL_HOST}
                  paths:
                  - path: /
                    pathType: Prefix
      flags:
        install: true
        createNamespace: true
        dependencyUpdate: true
 ```


### Customize and extend the charts

These recipes provide a standard, canonical, typical, or vanilla deployment for the TIBCO Platform Integration Application.

You are welcome to use and modify the recipes and adapt them to your specific use case, in compliance with the Apache License 2.0.
However, we recommend that you extend these charts, rather than modify them.
To extend the charts, create charts that import these official charts.
This way, it is easier for you to update your charts when new official recipes are released.
