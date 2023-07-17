### Jak uzyskać token API Cloudflare'a
1. Przejdź pod następujący link: https://dash.cloudflare.com/.
2. W prawym rogu kliknij ikonę profilu (człowiek w kółku). W przypadku wersji mobilnej strony, w lewym górnym rogu kliknij **Menu** (trzy poziome paski), w rozwijanym menu kliknij **My Profile**.
Do wyboru są cztery kategorie ustawień: *Communication*, *Authentication*, **API Tokens**, *Session*. Należy wybrać **API Tokens**.
4. Kliknij przycisk **Create token**.
5. Zjedź na dół, zobacz pole **Create Custom Token** i kliknij przycisk **Get Started** po prawej stronie.
6. W polu **Token Name** nadaj nazwę swojemu tokenowi.
7. Następnie mamy prawa dostępu. W skrajnie lewym polu wybierz **Zone**. W najdłuższym polu, środkowym, wybierz **DNS**. W skrajnie prawym polu wybierz **Edit**.
8. Następnie, tuż pod tym wierszem, kliknij Add more. Pojawi się podobne pole.
9. W skrajnie lewej części nowej linii wybierz to samo, co w poprzedniej linii - **Zone**. Środkowe pole jest nieco inne. Tutaj wybierz to samo, co na lewym marginesie - **Zone**. W skrajnie prawym marginesie wybierz **Read**.
10. Następnie spójrz na **Strefę zasobów**. Poniżej tego znajduje się linia z dwoma polami. W lewym powinno być **Include**, a w prawym **Specific Zone**. Gdy wybierzesz Specific Zone, po prawej stronie pojawi się kolejne pole. Wybierz w nim swoją domenę.
11. Przejdź na sam dół i kliknij niebieski przycisk **Continue to Summary**.
12. Sprawdź, czy wszystko zrobiłeś poprawnie. Powinna pojawić się podobna linia: *Domain - DNS:Edit, Zone:Read*.
13. Kliknij na **Create Token**.
14. Skopiuj utworzony token i zapisz go w bezpiecznym miejscu (najlepiej w menedżerze haseł).

![Cloudflare token setup](resource:assets/images/gifs/CloudFlare.gif)
