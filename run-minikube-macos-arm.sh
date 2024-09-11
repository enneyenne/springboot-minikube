echo "Installing docker..."
brew install --cask docker

echo "Installing minikube..."
brew install minikube

echo "Installing helm..."
brew install helm

echo "Opening docker..."
open -a docker

echo "Starting minikube..."
minikube start --force --driver=docker

echo "Installing ingress..."
minikube addons enable ingress
minikube addons enable ingress-dns

echo "Waiting up ingress..."
sleep 30

echo "Installing echo-server..."
helm install echo-server helm-charts/echo-server
helm install grafana helm-charts/grafana
helm install prometheus helm-charts/prometheus

echo "Add ip to /etc/hosts..."
#echo "$(minikube ip) echo-server" | sudo tee -a /etc/hosts >/dev/null
echo "127.0.0.1 echo-server" | sudo tee -a /etc/hosts >/dev/null
echo "127.0.0.1 grafana" | sudo tee -a /etc/hosts >/dev/null
echo "127.0.0.1 prometheus" | sudo tee -a /etc/hosts >/dev/null

echo "Enable tunnel..."
minikube tunnel