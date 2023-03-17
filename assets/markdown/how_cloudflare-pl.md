### Jak otrzymać Cloudflare API Token
1. Odwiedź ten link: https://dash.cloudflare.com/
2. W prawym rogu kliknij ikonę profilu (mężczyzna w kółku). W wersji mobilnej strony w lewym górnym rogu kliknij przycisk **Menu** (trzy poziome kreski), w rozwijanym menu kliknij **My profile**
3. Do wyboru są cztery kategorie konfiguracji: *Communication*, *Authentication*, **API Tokens**, *Session*. Wybierż **API Tokens**.
4. Kliknij na **Create Token**.
5. Zejdź na dół i zobacz **Create Custom Token** pole and naciśnij **Get Started** po prawej stronie.
6. W polu **Token Name** podaj nazwę swojego tokena.
7. Dalej mamy Uprawnienia. W skrajnym lewym polu wybierz **Zone**. W najdłuższym polu pośrodku wybierz **DNS**. W polu po prawej stronie wybierz **Edit**.
8. Następnie, tuż pod tą linią, kliknij Dodaj więcej. Pojawi się podobne okno.
9. W skrajnym lewym polu nowej linii wybierz, podobnie jak w ostatniej linii — **Zone**. W centrum — trochę inaczej: tutaj wybieramy to samo co po lewej — **Zone**. W polu po prawej stronie wybierz **Read**.
10. Następnie spójrz na **Zone Resources**. Pod tym napisem znajduje się linia z dwoma polami. Po lewej musi mieć opcję **Include**, a po prawej  **Specific Zone**. Po wybraniu określonej strefy po prawej stronie pojawi się kolejne pole. Wybierz w nim swoją domenę.
11. Przesuń w dół i naciśnij niebieski przycisk **Continue to Summary**.
12. Sprawdź, czy wszystko zrobiłeś dobrze. Podobny ciąg musi być obecny: *Domain — DNS:Edit, Zone:Read*.
13. Naciśnij na **Create Token**.
14. Stworzony token kopiujemy i zapisujemy w bezpiecznym miejscu (najlepiej w menedżerze haseł).

![Cloudflare token setup](resource:assets/images/gifs/CloudFlare.gif)
