# === Variables ===
$imageName = "elprofessorr/mon-image:latest"
$deploymentName = "mon-appli"

# === Étape 1: Aller dans le bon dossier (à adapter selon ton projet) ===
Set-Location D:\LTI\LTI2\DEVOPS\AppNodeJs\AppNodeJs

# === Étape 2: Pointer vers le Docker interne de Minikube ===
Write-Host " Configuration de l'environnement Docker de Minikube..."
& minikube -p minikube docker-env | Invoke-Expression

# === Étape 3: Reconstruire l'image Docker sans utiliser le cache ===
Write-Host " Construction de l'image Docker (sans cache)..."
docker build --no-cache -t $imageName .

# === Étape 4: Redémarrer le déploiement Kubernetes ===
Write-Host " Redémarrage du déploiement Kubernetes..."
kubectl rollout restart deployment $deploymentName

# === Étape 5: Attendre que les nouveaux pods soient prêts ===
Write-Host " Attente de stabilisation des pods..."
Start-Sleep -Seconds 5

# === Étape 6: Afficher l'état des pods ===
Write-Host " Pods actuels:"
kubectl get pods

# === Étape 7: (Optionnel) Afficher les logs des pods ===
Write-Host " Logs des derniers pods:"
kubectl logs -l app=mon-appli --tail=20

# === Étape 8: Accéder à l'application via le navigateur ===
Write-Host " Ouverture de l'application dans le navigateur..."
minikube service mon-appli-service