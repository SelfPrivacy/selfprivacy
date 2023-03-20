Zaloguj się jako użytkownik root na swoim serwerze i przejrzyj zawartość pliku `/etc/nixos/userdata/tokens.json`

```sh
cat /etc/nixos/userdata/tokens.json
```

This file will have a similar construction:

```json
{
    "tokens": [
        {
            "token": "token_to_copy",
            "name": "device_name",
            "date": "date"
        }
```

Copy the token from the file and paste it in the next window.
