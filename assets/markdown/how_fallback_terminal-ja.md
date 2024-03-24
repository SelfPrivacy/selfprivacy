In the Hetzner server control panel, go to the **Rescue** tab. Then, click on **Enable rescue & power cycle**.

In *Choose a Recue OS* select **linux64**, and in *SSH Key* select your key if it has been added to your Hetzner account.

Click **Enable rescue & power cycle** and wait for the server to reboot. The login and password will be displayed on the screen. Login to the root user using your login and password information.

Mount your server file system and see the contents of the token file:

```sh
mount /dev/sda1 /mnt
cat /mnt/etc/nixos/userdata/tokens.json
```

このファイルは同様の構造になっています。

```json
{
    "tokens": [
        {
            "token": "コピーするトークン",
            "name": "端末名",
            "date": "日付"
        }
```

ファイルからトークンをコピーして、次のウィンドウ内に貼り付けてください。
