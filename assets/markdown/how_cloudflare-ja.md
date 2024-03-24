### CloudflareのAPIトークンの取得方法
1. 次のリンクを開く: https://dash.cloudflare.com/
2. 右隅にあるプロフィールのアイコン（丸の内部の人間）をクリック。モバイル版のウェブページの場合は、**Menu** ボタン（三本の水平線）をクリックして、ドロップダウンメニューの **My Profile** をクリック。
3. 4つのカテゴリーが表示されるので、 **API Tokens** を選択。
4. **Create Token** のボタンをクリック。
5. 下部に移動し **Create Custom Token** の欄を確認したら、右側にある **Get Started** のボタンをクリック。
6. **Token Name** の欄に、任意のトークン名を入力。
7. 次に権限を設定。最も左にある欄で **Zone** を選択。最も長い欄で **DNS** を選択。最も右にある欄で **Edit** を選択。
8. 次に、この行の下にある Add More をクリック。同様の欄が表示されます。
9. 新しい行の最も左にある欄で **Zone** を選択。中央には、左欄と同じく **Zone** を選択。最も右にある欄で **Read** を選択。
10. 次に **Zone Resources** を確認。その下に、2つの欄の行が表示され、左には **Include** とあり、右には **Specific Zone** とあるはずです。Specific Zoneを選択したら、別の欄が右側に表示されます。あなたのドメインを選択してください。
11. 最も下に移動して、青色の **Continue to Summary** ボタンをクリック。
12. 全てを正しく設定しているか確認してください。以下のように表示されているはずです。*Domain — DNS:Edit, Zone:Read*。
13. **Create Token** をクリック。
14. トークンが表示されるので、パスワードマネージャーなどの安全な場所に保管してください。

![Cloudflareのトークンの設定](resource:assets/images/gifs/CloudFlare.gif)
