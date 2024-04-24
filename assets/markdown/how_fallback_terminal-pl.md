W panelu sterowania serwera Hetzner przejdź do zakładki **Rescue**. Następnie kliknij **Enable rescue & power cycle**.

W *Choose a Recue OS* wybierz **linux64**, a w *SSH Key* swój klucz, jeśli został dodany do konta Hetznera.

Naciśnij **Enable rescue & power cycle** i poczekaj na ponowne uruchomienie serwera. Zostanie wyświetlone hasło logowania. Zaloguj się na użytkownika root, używając informacji o loginie i haśle.

Zamontuj system plików swojego serwera i spójrz na zawartość pliku token:

```sh
mount /dev/sda1 /mnt
cat /mnt/etc/nixos/userdata/tokens.json
```

W tym pliku będzie podobny wzór:

`json
{
    { "tokens": [
        {
            { "token": "token_który_był_skopedowany",
            { "name": "device_name",
            { "data": "data"
        }
```

Skopiuj token z pliku i wklej w następnym oknie.
