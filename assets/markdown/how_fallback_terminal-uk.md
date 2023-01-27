На панелі керування сервером Hetzner перейдіть на вкладку **Rescue**. Після цього натисніть кнопку **увімкнути цикл порятунку та живлення**.

In *Choose a Recue OS* select **linux64**, and in *SSH Key* select your key if it has been added to your Hetzner account.

Натисніть **Enable rescue & power cycle** і зачекайте, поки сервер перезавантажить. На екрані з'явиться логін і пароль. Увійдіть до користувача root за допомогою вашої реєстраційних даних і паролів.

Змонтувати файлову систему вашого сервера і переглянути вміст файла токенів:

```sh
mount /dev/sda1 /mnt
cat /mnt/etc/nixos/userdata/tokens.json
```

Цей файл буде мати подібну конструкцію:

```json
{
    "tokens": [
        {
            "token": "token_to_copy",
            "name": "device_name",
            "date": "date"
        }
```

Скопіюйте токен з файла і вставте його в наступне вікно.
