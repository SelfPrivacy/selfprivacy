### So erhalten Sie das Cloudflare-API-Token
1. Besuchen Sie den folgenden Link: https://dash.cloudflare.com/
2. Klicken Sie in der rechten Ecke auf das Profilsymbol (ein Mann im Kreis). Klicken Sie für die mobile Version der Website in der oberen linken Ecke auf die Schaltfläche **Menu** (drei horizontale Balken) und im Dropdown-Menü auf **My Profile**
3. Es stehen vier Konfigurationskategorien zur Auswahl: *Communication*, *Authentication*, **API Tokens**, *Session*. Choose **API Tokens**.
4. Klicken Sie auf die Schaltfläche **Create Token**.
5. Gehen Sie nach unten und sehen Sie sich das Feld **Create Custom Token** an und klicken Sie auf die Schaltfläche **Get Started** auf der rechten Seite.
6. Geben Sie Ihrem Token im Feld **Token Name** einen Namen.
7. Als nächstes haben wir Berechtigungen. Wählen Sie im linken Feld **Zone** aus. Wählen Sie im längsten Feld in der Mitte **DNS** aus. Wählen Sie im Feld ganz rechts **Edit** aus.
8. Klicken Sie als Nächstes direkt unter dieser Zeile auf Mehr hinzufügen. Ein ähnliches Feld wird angezeigt.
9. Wählen Sie im linken Feld der neuen Zeile ähnlich wie in der letzten Zeile — **Zone**. In der Mitte – etwas anders. Wählen Sie hier dasselbe wie links – **Zone**. Wählen Sie im Feld ganz rechts **Read** aus.
10. Sehen Sie sich als Nächstes **Zone Resources** an. Unter dieser Inschrift befindet sich eine Zeile mit zwei Feldern. Auf der linken Seite muss **Include** und auf der rechten Seite **Specific Zone** stehen. Nachdem Sie Spezifische Zone ausgewählt haben, erscheint rechts ein weiteres Feld. Wählen Sie darin Ihre Domain aus.
11. Blättern Sie nach unten und drücken Sie die blaue Schaltfläche **Continue to Summary**.
12. Überprüfen Sie, ob Sie alles richtig gemacht haben. Eine ähnliche Zeichenfolge muss vorhanden sein: *Domain — DNS:Edit, Zone:Read*.
13. Klicken Sie auf **Create Token**.
14. Wir kopieren das erstellte Token und speichern es an einem zuverlässigen Ort (vorzugsweise im Passwort-Manager).

![Cloudflare token Einrichtung](resource:assets/images/gifs/CloudFlare.gif)
