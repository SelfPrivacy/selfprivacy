In the Hetzner server control panel, go to the **Rescue** tab. Then, click on **Enable rescue & power cycle**.

In *Choose a Recue OS* select **linux64**, and in *SSH Key* select your key if it has been added to your Hetzner account.

Click **Enable rescue & power cycle** and wait for the server to reboot. The login and password will be displayed on the screen. Login to the root user using your login and password information.

Mount your server file system and see the contents of the token file:

```sh
mount /dev/sda1 /mnt
cat /mnt/etc/nixos/userdata/tokens.json
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
