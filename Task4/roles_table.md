| Роль             | Права роли                                                         | Группы пользователей              |
|------------------|--------------------------------------------------------------------|-----------------------------------|
| secret-manager   | Полный доступ к secrets (get, list, create, update, delete)        | Security Team                     |
| cluster-configurator | Полный доступ к pods, services, configmaps, namespaces, deployments | DevOps Team                       |
| cluster-viewer   | Только чтение ресурсов (get, list, watch)                      | Auditors, Management              |