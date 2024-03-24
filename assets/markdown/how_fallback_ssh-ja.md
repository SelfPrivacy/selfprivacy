ルートユーザーとしてサーバーにログインして、ファイル `/etc/nixos/userdata/tokens.json` の内容を確認してください。

```sh
cat /etc/nixos/userdata/tokens.json
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
