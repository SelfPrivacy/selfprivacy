V ovládacím panelu serveru Hetzner přejděte na kartu **Rescue**. Poté klikněte na možnost **Enable rescue & power cycle**.

V části *Choose a Recue OS* vyberte **linux64** a v části *SSH Key* vyberte svůj klíč, pokud byl přidán do vašeho účtu Hetzner.

Klikněte na tlačítko **Enable rescue & power cycle** a počkejte, až se server restartuje. Na obrazovce se zobrazí přihlašovací jméno a heslo. Přihlaste se k uživateli root pomocí přihlašovacích údajů a hesla.

Připojte souborový systém serveru a zobrazte obsah souboru token:

```sh
mount /dev/sda1 /mnt
cat /mnt/etc/nixos/userdata/tokens.json
```

Tento soubor bude mít podobnou konstrukci:

```json
{
    "tokens": [
        {
            "token": "token_ke_zkopírování",
            "name": "název_zařízení",
            "date": "datum"
        }
```

Zkopírujte token ze souboru a vložte jej do dalšího okna.
