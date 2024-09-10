echo "Installing qemu..."
brew install qemu

echo "Installing minikube..."
brew install minikube

echo "Installing helm..."
brew install helm

echo "Installing socket_vmnet..."
brew install socket_vmnet
brew tap homebrew/services
HOMEBREW=$(which brew) && sudo ${HOMEBREW} services start socket_vmnet

echo "Starting minikube..."
minikube start --driver qemu --network socket_vmnet

echo "Installing ingress..."
minikube addons enable ingress

echo "Installing echo-server..."
helm install backend-echo-server helm-charts/backend-echo-server