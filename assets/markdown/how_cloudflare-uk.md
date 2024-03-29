### Як отримати токен Cloudflare API
1. Перейдіть за цим посиланням: https://dash.cloudflare.com/
2. В правому куті натисніть на іконку профілю (людина в колі). Для мобільної версії сайту, у верхньому лівому кутку натисніть кнопку **Menu** (три горизонтальні смужки), у випадаючому меню натисніть **My profile**
3. Є чотири категорії конфігурації на вибір: *Communication*, *Authentication*, **API Tokens**, *Session*. Виберіть **API Tokens**.
4. Натисніть кнопку **Create Token**.
5. Спустіться вниз і перегляньте поле **Create Custom Token** і натисніть кнопку **Get Started** праворуч.
6. У полі **Назва токена** введіть назву токена.
7. Далі у нас є Дозволи. У крайньому лівому полі виберіть **Zone**. У найдовшому полі по центру виберіть **DNS**. У крайньому правому полі виберіть **Edit**.
8. Далі прямо під цим рядком натисніть «Add more». З'явиться аналогічне поле.
9. У крайньому лівому полі нового рядка виберіть, як і в останньому рядку, — **Zone**. У центрі — трохи інше. Тут вибираємо те саме, що й зліва — **Zone**. У крайньому правому полі виберіть **Read**.
10. Далі подивіться на **Zone Resources**. Під цим написом — рядок із двома полями. Ліворуч має бути **Include**, а праворуч має бути **Specific Zone**. Після вибору «Specific Zone» праворуч з’явиться ще одне поле. Виберіть у ньому свій домен.
11. Прокрутіть униз і натисніть синю кнопку **Continue to Summary**.
12. Перевірте, чи все ви зробили правильно. Подібний рядок має бути присутнім: *Domain — DNS:Edit, Zone:Read*.
13. Натисніть **Create Token**.
14. Копіюємо створений токен і зберігаємо в надійному місці (бажано в менеджері паролів).

![Cloudflare налаштування токена](resource:assets/images/gifs/CloudFlare.gif)
