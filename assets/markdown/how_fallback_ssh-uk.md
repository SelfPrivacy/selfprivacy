Увійдіть від користувача root до вашого сервера і подивіться на вміст файла`/etc/nixos/userdata/tokens.json`

```sh
cat /etc/nixos/userdata/tokens.json
```

Цей файл буде мати подібну конструкцію:

```json
{
    "tokens": [
        {
            "token": "token_to_copy",
            "name": "device_name",
            "date": "date"
        }
```

Скопіюйте токен з файла і вставте його в наступне вікно.
