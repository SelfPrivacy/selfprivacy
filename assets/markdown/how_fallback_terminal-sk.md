V ovládacom paneli servera Hetzner prejdite na kartu **Rescue**. Potom kliknite na **Enable rescue & power cycle**.

V časti *Choose a Recue OS* vyberte **linux64** a v časti *SSH Key* vyberte svoj kľúč, ak bol pridaný do vášho účtu Hetzner.

Stlačte tlačidlo **Enable rescue & power cycle** a počkajte, kým sa server reštartuje. Zobrazí sa prihlasovacie heslo. Prihláste sa ako používateľ root pomocou prihlasovacích údajov a hesla.

Pripojte súborový systém servera a pozrite si obsah súboru token:

```sh
mount /dev/sda1 /mnt
cat /mnt/etc/nixos/userdata/tokens.json
```

V tomto súbore bude podobný dizajn:

``json
{
    {"tokens": [
        {
            {"token": "token_which_has_been_scoped",
            {"name": "device_name",
            {"date": "date"
        }
```

Skopírujte token zo súboru a vložte ho do ďalšieho okna.
