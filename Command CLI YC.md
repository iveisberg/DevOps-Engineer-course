## CLI YandexCloud

Чтобы начать настройку профиля CLI, выполните команду:
yc init

Проверьте настройки вашего профиля CLI:
yc config list

yc vpc network list

yc vpc network list --format yaml

yc vpc subnet list

yc compute image list

Получить информацию о ВМ вместе с пользовательскими метаданными можно с помощью команды:
yc compute instance get --full <имя_ВМ>
yc compute instance get docker-in-practice-2

Подключитесь к ВМ через OS Login. Для этого выполните команду:
yc compute ssh --name <имя_ВМ> --folder-id <идентификатор_каталога>


В конфигурации ВМ вам потребуется указать идентификатор образа загрузочного диска. Список доступных публичных образов можно получить командой CLI:
yc compute image list --folder-id standard-images


## YC registry

yc container registry create --name test
yc container registry list
docker tag web cr.yandex/crpilqlhcn2l16p788kv/web:latest
docker push cr.yandex/crpilqlhcn2l16p788kv/web:latest
yc container image get crpn3cfcajo64v6bj0bq
----------------------------------------------------------


## SSH

Чтобы сгенерировать пару SSH-ключей, в консоли Linux или Windows выполните команду:
ssh-keygen -t ed25519

Параметр –t задает тип создаваемого ключа. Для Yandex Cloud рекомендуется создавать ключи Ed25519 (т. е. на основе криптографического алгоритма Ed25519).

cat ~/.ssh/<имя_ключа>.pub

Открытый ключ будет выведен на экран. Выделите текст и скопируйте его в буфер обмена. Например: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5ABFLIFyapYheN7OZNhTaNqEHefjmU5mtzK********+gRPCz user@Desktop.

ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>

Если у вас несколько закрытых ключей, укажите нужный:
ssh -i <путь_к_ключу/имя_файла_ключа> <имя_пользователя>@<публичный_IP-адрес_ВМ>


Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: eval $(ssh-agent) && ssh-add
----------------------------------------------------------

# service_account_key_file

yc iam key create   --service-account-id ajep3ai8jorvcb5trhbh   --folder-name netology-homework   --output key.json

yc config profile create sa-terraform
yc config set service-account-key key.json
yc config list
yc config set cloud-id b1g3h5uouq196iot3aqf
yc config set folder-id b1gue9v1tapk50i3uj7m

yc config profile list

# iam create-token

export YC_TOKEN=$(yc iam create-token) \
export YC_CLOUD_ID=$(yc config get cloud-id) \
export YC_FOLDER_ID=$(yc config get folder-id)

export TF_VAR_YC_TOKEN=$(yc iam create-token)
export TF_VAR_YC_CLOUD_ID=$(yc config get cloud-id)
export TF_VAR_YC_FOLDER_ID=$(yc config get folder-id)

token = var.YC_TOKEN