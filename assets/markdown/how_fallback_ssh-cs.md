Přihlaste se k serveru jako uživatel root a podívejte se na obsah souboru `/etc/nixos/userdata/tokens.json`

```sh
cat /etc/nixos/userdata/tokens.json
```

Tento soubor bude mít podobnou konstrukci:

```json
{
    "tokens": [
        {
            "token": "token_to_copy",
            "name": "device_name",
            "date": "date"
        }
```

Zkopírujte token ze souboru a vložte jej do dalšího okna.
