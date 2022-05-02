# explorify_205

Project D Changes:

-Notifications:
App delivers a notification every minute for testing purposes. 
Normally it would deliver once every couple of days.


-Other services:
We implemented a splash screen and a custom made icon for our app.

We implemented Connectivity that gives the user information about their connection to the internet.

We also show the user information about their device and battery level.


-Security Measures:
We implemented a fingerprint based authorization for our app. This is done in the fingerprint_auth class.
App will output a message to the terminal based on the biometrics of the phone.
Fingerprint system will not work if the device doesn't have fingerprints set up.

We implemented a Cache Controller that cleans caches after 15 minutes when the app is not in use.
This is located in the main.dart

We implemented a jailbreak detection system that gives information about the jailbreak status of the device.

We implemented flutter_windowmanager which allows us to secure screens and prevent user from taking screenshots.
This is implemented in the Login Page.

We also tried to obfuscate our code but it caused a lot of errors related to our assets so we decided against it.


-From Part C
We didn't use remote database for part C. We added a simple method that pulls an Album from Remote Database in our charts_page.


-Some notes

Home page doesn't display the data correctly on initial launch. We couldn't fix the issue but simply switching pages resolves it.
You can use test@gmail.com 123456 for testing if you don't want to sign up