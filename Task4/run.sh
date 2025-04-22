#!/bin/bash
echo "Создание сервисных аккаунтов..."
bash create-users.sh

echo "Создание ролей..."
kubectl apply -f create-roles.yaml

echo "Создание привязок ролей..."
kubectl apply -f create-bindings.yaml

echo "Готово!"