# Kubernetes Deployment

## Quick Start

```bash
kubectl apply -f docs/kubernetes/
```

This deploys a Deployment and ClusterIP Service with no namespace set — add `-n <namespace>` or set it in your kustomization overlay.

## Manifests

| File | Description |
|------|-------------|
| [deployment.yaml](deployment.yaml) | Deployment with security hardening, resource limits, and health checks |
| [service.yaml](service.yaml) | ClusterIP Service mapping port 80 to container port 8080 |

The manifests are generic templates — no namespace, no ingress, no environment-specific values. Apply them directly or use them as a kustomize base.

## Exposing the Service

Example routing manifests for common ingress/gateway setups:

| File | Description |
|------|-------------|
| [httproute-example.yaml](httproute-example.yaml) | Gateway API HTTPRoute |
| [ingress-example.yaml](ingress-example.yaml) | Nginx Ingress |
| [envoyfilter-example.yaml](envoyfilter-example.yaml) | Istio/Envoy error page injection |

## Custom Playlists

Mount a playlist config via ConfigMap — see [configmap-playlists-example.yaml](configmap-playlists-example.yaml) for a working example that patches the deployment with the volume and `FAIRER_PLAYLIST_FILE` environment variable.

See [default-playlists.yml](../../default-playlists.yml) for the full syntax reference.

## Security Context

The deployment enforces:

- **Non-root**: Runs as UID/GID 10000
- **Read-only root filesystem**: Only `/tmp` is writable (emptyDir)
- **No privilege escalation**: `allowPrivilegeEscalation: false`
- **All capabilities dropped**: `capabilities.drop: [ALL]`
