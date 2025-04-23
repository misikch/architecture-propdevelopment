#!/bin/bash

# Создаем minikube если еще не запущен
if ! minikube status &>/dev/null; then
  echo "Запускаем Minikube..."
  minikube start
fi

# Включаем дополнение для сетевых политик
echo "Включаем поддержку NetworkPolicy в Minikube..."
minikube addons enable network-policy

# Создаем сервисы
echo "Создаем сервисы..."
bash create-services.sh

# Применяем сетевые политики
echo "Применяем сетевые политики..."
kubectl apply -f non-admin-api-allow.yaml

# Даем время на применение политик
echo "Ожидаем применения политик..."
sleep 5

# Функция для тестирования соединения
test_connection() {
  local from=$1
  local to=$2
  echo "Тест: $from -> $to"
  kubectl exec $from -- wget -qO- --timeout=2 http://$to 2>/dev/null
  if [ $? -eq 0 ]; then
    echo "✅ Соединение разрешено"
  else
    echo "❌ Соединение запрещено"
  fi
}

# Тестируем соединения
echo "Тестируем сетевые политики..."
test_connection front-end-app back-end-api-app
test_connection back-end-api-app front-end-app
test_connection admin-front-end-app admin-back-end-api-app
test_connection admin-back-end-api-app admin-front-end-app

# Тестируем запрещенные соединения
test_connection front-end-app admin-back-end-api-app
test_connection admin-front-end-app back-end-api-app

echo "Тестирование завершено."
