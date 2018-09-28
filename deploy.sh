if [[ ! $1 ]]; then echo "Error: An environment name (development or production) is required."; exit 1; fi

APP_NAME="fluentbit-to-elasticsearch" 
NAMESPACE="monitoring" 
FLUENT_ELASTICSEARCH_HOST=$(vault read -field=value secret/***/elasticsearch/host)
FLUENT_ELASTICSEARCH_PORT=$(vault read -field=value secret/***/elasticsearch/port)
HTTP_User=$(vault read -field=value secret/***/elasticsearch/user)
HTTP_Passwd=$(vault read -field=value secret/***/elasticsearch/password)
TLS="On"

kubectl create clusterrolebinding fluent-bit \
  --clusterrole fluent-bit \
  --user $(gcloud config get-value account)
  --namespace ${NAMESPACE}

for f in *.yaml; do
    APP_NAME=${APP_NAME} \
    NAMESPACE=${NAMESPACE} \
    FLUENT_ELASTICSEARCH_HOST=${FLUENT_ELASTICSEARCH_HOST} \
    FLUENT_ELASTICSEARCH_PORT=${FLUENT_ELASTICSEARCH_PORT} \
    HTTP_User=${HTTP_User} \
    HTTP_Passwd=${HTTP_Passwd} \
    TLS=${TLS} \
    ENVIRONMENT=$1 \
        consul-template -template "$f" -once -dry | sed '1d' | kubectl apply -f -
done
