Увайдзіце на ваш сервер як root карыстальнік і праглядзіце змесціва файла `/etc/nixos/userdata/tokens.json`

```sh
cat /etc/nixos/userdata/tokens.json
```

Гэты файл будзе мець падобную канструкцыю:

```json
{
    "tokens": [
        {
            "token": "token_to_copy",
            "name": "device_name",
            "date": "date"
        }
```

Скапіруйце токен з файла і ўстаўце яго ў наступнае акно.
