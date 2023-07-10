### Ako získať token API Cloudflare
1. Navštívte nasledujúce prepojenie: https://dash.cloudflare.com/
2. V pravom rohu kliknite na ikonu profilu (muž v kruhu). V prípade mobilnej verzie stránky kliknite v ľavom hornom rohu na tlačidlo **Menu** (tri vodorovné pruhy), v rozbaľovacej ponuke kliknite na **My profile**
3. Na výber sú štyri kategórie konfigurácie: *Communication*, *Authentication*, **Toky API**, *Session*. Vyberte **API Tokens**.
4. Kliknite na tlačidlo **Create Token**.
5. Prejdite na spodnú časť a zobrazte pole **Create Custom Token** a stlačte tlačidlo **Get Started** na pravej strane.
6. V poli **Token Name** zadajte svoj token.
7. Ďalej tu máme položku Permissions. V ľavom krajnom poli vyberte položku **Zone**. V najdlhšom poli uprostred vyberte položku **DNS**. V krajnom pravom poli vyberte položku **Edit**. 
8. Ďalej priamo pod týmto riadkom kliknite na položku **Pridať ďalšie**. Zobrazí sa podobné pole.
9. V krajnom ľavom poli nového riadku vyberte podobne ako v predchádzajúcom riadku - **Zone**. V strede - trochu inak. Tu vyberte rovnako ako v ľavom poli - **Zone**. V krajnom pravom poli vyberte položku **Read**.
10. Ďalej sa pozrite na položku **Zone Resources**. Pod týmto nápisom sa nachádza riadok s dvoma poľami. V ľavom musí byť uvedené **Include** a v pravom **Specific Zone**. Keď vyberiete položku **Špecifická zóna**, vpravo sa objaví ďalšie pole. V ňom vyberte svoju doménu.
11. Prejdite na spodnú časť a stlačte modré tlačidlo **Continue to Summary**.
12. Skontrolujte, či máte všetko správne. Musí sa vyskytovať podobný reťazec: *Domain — DNS:Edit, Zone:Read*.
13. Kliknite na **Create Token**.
14. Vytvorený token skopírujeme a uložíme ho na spoľahlivé miesto (najlepšie do správcu hesiel).

![Cloudflare token setup](resource:assets/images/gifs/CloudFlare.gif)
