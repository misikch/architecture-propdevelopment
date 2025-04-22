Запуск настройки и тестирования:
```bash
./setup-and-test.sh
```

Или вручную:
# Создаем тестовый под
```bash
kubectl run test-$RANDOM --rm -i -t --image=alpine -- sh
```

# Внутри запущенного пода выполняем:
```bash
wget -qO- --timeout=2 http://front-end-app
wget -qO- --timeout=2 http://back-end-api-app
wget -qO- --timeout=2 http://admin-front-end-app
wget -qO- --timeout=2 http://admin-back-end-api-app
```
Все соединения должны быть запрещены, 
так как тестовый под не имеет необходимых меток для прохождения через сетевые политики.