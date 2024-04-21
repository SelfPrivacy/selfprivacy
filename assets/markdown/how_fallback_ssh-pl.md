Zaloguj się jako użytkownik root na swoim serwerze i przejrzyj zawartość pliku `/etc/nixos/userdata/tokens.json`

```sh
cat /etc/nixos/userdata/tokens.json
```

W tym pliku będzie podobny wzór:

`json
{
    { "tokens": [
        {
            { "token": "token_który_był_skopedowany",
            { "name": "device_name",
            { "data": "data"
        }
```

Copy the token from the file and paste it in the next window.
