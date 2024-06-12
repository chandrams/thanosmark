export $(grep -v '^#' .env | xargs)

kubectl delete -n ${NAMESPACE} --all deployments
kubectl delete -n ${NAMESPACE} --all services
kubectl delete -n ${NAMESPACE} --all statefulsets
kubectl delete -n ${NAMESPACE} --all persistentvolumeclaims
kubectl delete -n ${NAMESPACE} --all secrets
kubectl delete -n ${NAMESPACE} --all configmaps
kubectl delete -n ${NAMESPACE} --all jobs
kubectl delete -n ${NAMESPACE} --all serviceaccounts
kubectl delete -n ${NAMESPACE} --all poddisruptionbudgets
kubectl delete -n ${NAMESPACE} --all roles
kubectl delete -n ${NAMESPACE} --all rolebindings
