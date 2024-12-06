### Come ottenere il token API di Cloudflare
1. Visita il seguente link: https://dash.cloudflare.com/
2. Nell'angolo destro, clicca sull'icona del profilo (un uomo in un cerchio). Per la versione mobile del sito, nell'angolo superiore sinistro, fai clic sul pulsante **Menu** (tre barre orizzontali), nel menu a discesa, fai clic su **Il mio profilo**.
3. È possibile scegliere tra quattro categorie di configurazione: *Comunicazione*, *Autenticazione*, **Token API**, *Sessione*. Scegliere **Token API**.
4. Fai clic sul pulsante **Crea token**.
5. Scendi in fondo e visualizza il campo **Crea Token Personalizzato** e premete il pulsante **Introduzione** sul lato destro.
6. Nel campo **Nome token**, dai un nome al tuo token.
7. Poi ci sono le autorizzazioni. Nel campo più a sinistra, seleziona **Zona**. Nel campo più lungo, al centro, seleziona **DNS**. Nel campo più a destra, seleziona **Modifica**. 
8. Successivamente, proprio sotto questa riga, fai clic su Aggiungi altro. Apparirà un campo simile.
9. Nel campo più a sinistra della nuova riga, seleziona, in modo simile all'ultima riga, **Zona**. Al centro - un po' diverso. Sceglie lo stesso campo della riga di sinistra: **Zona**. Nel campo più a destra, seleziona **Lettura**.
10. Guarda quindi **Risorse della zona**. Sotto questa scritta c'è una riga con due campi. A sinistra deve esserci **Include** e a destra **Zona specifica**. Una volta selezionata la voce Zona specifica, appare un altro campo sulla destra. Sceglie il tuo dominio in esso.
11. Scorri verso il fondo e premei il pulsante blu **Continua al riepilogo**.
12. Verifica se hai fatto tutto correttamente. Deve essere presente una stringa simile: *Dominio - DNS:Modifica, Zona:Leggi*.
13. Fai clic su **Crea token**.
14. Copia il token creato e salvalo in un luogo affidabile (preferibilmente in un gestore di password).

![Impostazione del token Cloudflare](resource:assets/images/gifs/CloudFlare.gif)
