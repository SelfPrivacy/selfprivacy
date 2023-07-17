Prihláste sa ako používateľ root na server a pozrite sa na obsah súboru `/etc/nixos/userdata/tokens.json

```sh
cat /etc/nixos/userdata/tokens.json
```

V tomto súbore bude podobný dizajn:

``json
{
    {"tokens": [
        {
            {"token": "token_which_has_been_scoped",
            {"name": "device_name",
            {"date": "date"
        }
```

Skopírujte token zo súboru a vložte ho do ďalšieho okna.
