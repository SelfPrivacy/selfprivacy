Hetznerのサーバーコントロールパネルで **Rescue** タブを開いてください。その後 **Enable rescue & power cycle** をクリックしてください。

*Choose a Recue OS* で **linux64** を選択し、 *SSH Key* で、HetznerのアカウントにSSH鍵を登録している場合は、これを選択してください。

**Enable rescue & power cycle** をクリックして、サーバーが再起動するまでお待ちください。ログインとパスワードがスクリーンに表示されます。ログインとパスワード情報を使用して、ルートユーザーにログインしてください。

サーバーのファイルシステムをマウントして、トークンファイルの中身を確認してください。

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
