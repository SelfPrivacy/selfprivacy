### How to get Cloudflare API Token
1. Visit the following link: https://dash.cloudflare.com/
2. the right corner, click on the profile icon (a man in a circle). For the mobile version of the site, in the upper left corner, click the **Menu** button (three horizontal bars), in the dropdown menu, click on **My Profile**
3. There are four configuration categories to choose from: *Communication*, *Authentication*, **API Tokens**, *Session*. Choose **API Tokens**.
4. Click on **Create Token** button.
5. Go down to the bottom and see the **Create Custom Token** field and press **Get Started** button on the right side.
6. In the **Token Name** field, give your token a name.
7. Next we have Permissions. In the leftmost field, select **Zone**. In the longest field, center, select **DNS**. In the rightmost field, select **Edit**. 
8. Next, right under this line, click Add More. Similar field will appear.
9. In the leftmost field of the new line, select, similar to the last line — **Zone**. In the center — a little different. Here choose the same as in the left — **Zone**. In the rightmost field, select **Read**.
10. Next look at **Zone Resources**. Under this inscription there is a line with two fields. The left must have **Include** and the right must have **Specific Zone**. Once you select Specific Zone, another field appears on the right. Choose your domain in it.
11. Flick to the bottom and press the blue **Continue to Summary** button.
12. Check if you got everything right. A similar string must be present: *Domain — DNS:Edit, Zone:Read*.
13. Click on **Create Token**.
14. We copy the created token, and save it in a reliable place (preferably in the password manager).

![Cloudflare token setup](resource:assets/images/gifs/CloudFlare.gif)
