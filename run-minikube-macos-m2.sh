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

echo "Installing echo-server..."
helm install echo-server helm-charts/echo-server

echo "Add ip to /etc/hosts..."
echo "$(minikube ip) echo-server.local" | sudo tee -a /etc/hosts >/dev/null
echo "127.0.0.1 echo-server.local" | sudo tee -a /etc/hosts >/dev/null

echo "Enable tunnel..."
sudo minikube tunnel

curl 'http://echo-server.local?message=Hello,%20World'