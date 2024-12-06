Nel pannello di controllo del server su Hetzner, vai su **Rescue**. Quindi, clicca su **Enable rescue & power cycle**.

In *Choose a Recue OS* seleziona **linux64**, ed in *SSH Key* seleziona la tua chiave se è stata aggiunta al tuo account Hetzner.

Clicca su **Enable rescue & power cycle** ed attendi il riavvio del server. Login e password saranno mostrate sullo schermo. Loggati come utente root usando la tua login e password.

Monta il file system del server e guarda il contenuto del file token:

```sh
mount /dev/sda1 /mnt
cat /mnt/etc/nixos/userdata/tokens.json
```

Il file avrà una struttura simile:

```json
{
    "tokens": [
        {
            "token": "token_da_copiare",
            "name": "nome_dispositivo",
            "date": "data"
        }
```

Copia il token dal file e incollalo nella schermata successiva.
