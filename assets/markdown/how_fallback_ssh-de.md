Melden Sie sich als Root-Benutzer auf Ihrem Server an und sehen Sie sich den Inhalt der Datei `/etc/nixos/userdata/tokens.json` an

```sh
cat /etc/nixos/userdata/tokens.json
```

Diese Datei hat einen ähnlichen Aufbau:

```json
{
    "tokens": [
        {
            "token": "token_zum_Kopieren",
            "name": "Gerätname",
            "date": "Datum"
        }
```

Kopieren Sie das Token aus der Datei und fügen Sie es im nächsten Fenster ein.
