Login as root user to your server and look at the contents of the file `/etc/nixos/userdata/tokens.json`

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
