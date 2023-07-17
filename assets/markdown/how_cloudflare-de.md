### Wie man Cloudflare API Token bekommt
1. Besuchen Sie den folgenden link: https://dash.cloudflare.com/
2. Klicken Sie in der rechten Ecke auf das Profilsymbol (ein Mann in einem Kreis). Bei der mobilen Version der Website klicken Sie in der oberen linken Ecke auf die Schaltfläche **Menu** (drei horizontale Balken), im Dropdown-Menü klicken Sie auf **My Profile**
3. Es gibt vier Konfigurationskategorien, aus denen Sie wählen können: *Communication*, *Authentication*, **API Tokens**, *Session*. Wählen Sie **API Tokens**.
4. Klicken Sie auf die Schaltfläche **Create Token**.
5. Gehen Sie nach unten und sehen Sie das Feld **Create Custom Token** und klicken Sie auf der rechten Seite auf die Schaltfläche **Get Started**.
6. Geben Sie in das Feld **Token Name** einen Namen für Ihr Token ein.
7. Als nächstes folgen die Berechtigungen. Wählen Sie im Feld ganz links **Zone**. Wählen Sie im längsten Feld in der Mitte **DNS**. Wählen Sie im Feld ganz rechts **Edit**. 
8. Klicken Sie anschließend direkt unter dieser Zeile auf Add More. Ein ähnliches Feld wird angezeigt.
9. Wählen Sie im ganz linken Feld der neuen Zeile, ähnlich wie in der letzten Zeile, **Zone**. In der Mitte - ein wenig anders. Wählen Sie hier dasselbe wie in der linken Zeile - **Zone**. Im Feld ganz rechts wählen Sie **Read**.
10. Als nächstes sehen Sie sich **Zone Resources** an. Unter dieser Aufschrift befindet sich eine Zeile mit zwei Feldern. Auf der linken Seite muss **Include** und auf der rechten Seite **Specific Zone** stehen. Sobald Sie Spezifische Zone auswählen, erscheint rechts ein weiteres Feld. Wählen Sie dort Ihre Domain aus.
11. Streichen Sie nach unten und drücken Sie die blaue Schaltfläche **Continue to Summary**.
12. Überprüfen Sie, ob Sie alles richtig gemacht haben. Eine ähnliche Zeichenfolge muss vorhanden sein: *Domain — DNS:Edit, Zone:Read*.
13. Klicken Sie auf **Create Token**.
14. Kopieren Sie das erstellte Token und speichern Sie es an einem zuverlässigen Ort (vorzugsweise im Passwort-Manager).

![Cloudflare token Einrichtung](resource:assets/images/gifs/CloudFlare.gif)
