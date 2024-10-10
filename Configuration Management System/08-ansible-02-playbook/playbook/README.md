# Ansible Playbook для установки Clickhouse и Vector

## Описание

Этот playbook предназначен для автоматизации процесса установки и настройки Clickhouse и Vector на хостах, использующих Ansible. Он включает в себя установку необходимых пакетов, настройку базы данных для Clickhouse и установку Vector с использованием шаблона конфигурации Jinja2.

## Параметры

- `clickhouse_version`: Версия Clickhouse, которая будет установлена (например, `22.3`).
- `clickhouse_packages`: Список пакетов Clickhouse, которые будут загружены (например, `["clickhouse-client", "clickhouse-server"]`).
- `vector_version`: Версия Vector, которая будет установлена (например, `0.17.0`).

## Теги

- `clickhouse`: Устанавливает и настраивает Clickhouse.
- `vector`: Устанавливает и настраивает Vector.

## Зависимости

- Ansible версии 2.9 или выше.
- Для работы с системами, совместимыми с RPM (например, CentOS, RHEL).

## Как использовать

1. Склонируйте репозиторий с playbook и шаблоном.
2. Заполните необходимые параметры в вашем inventory файле.
3. Выполните playbook с помощью команды:
```
ansible-playbook site.yml
```
4. Убедитесь, что службы Clickhouse и Vector работают корректно.