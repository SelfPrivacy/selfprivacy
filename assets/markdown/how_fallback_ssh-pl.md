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

Skopiuj token z pliku i wklej w następnym oknie.
