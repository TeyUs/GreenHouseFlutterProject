# GreenHouse Controls App

Prepared for a school project. It is a mobile application that aims to present the greenhouse temperature data received from the server to the user every second and to adjust the temperature of the greenhouse via the server.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Content
Sera sıcaklık bilgisi ekranda bulunan "GreenHouse Temperature : " ifadesinden sonra gelecek şekilde yerleştirilmiştir, uygulama açıldığı anda çalışmaya başlar ve saniyede bir yenilenir. "Desired Temperature" kutusunun içine yazılan sıcaklık değeri "Send Temperature" butonuna dokunulduğu takdirde server aracılığıyla seraya iletilecektir.

## Detailed Content

getMessage metodu; initState metodu(uygulama açıldığı zaman kendiliğinden çalışan metot) içinde başlatılır, böylece uygulama açıldığı anda serverdan sıcaklık değeri almaya başlanır. Server Url'sine "authorization" için userName = "admin", passWord = "123" olarak ayarlanır ve get metodu çağılır. Eğer 200 Status Code'u dönerse response.body.currentTemp değeri gelen json içinden çekilir. Ekrandaki uygun alan bu değerle ayarlanır.

sendMessage metodu; "Send Temperature" yazılı butona dokunulduğu zaman çalışır. "Desired Temperature" yazılı "TextFormField" içinde yazılı değer, gönderilecek json içindeki "desiredTemp" parametresine ayarlanır. Ayrıca "Iso8601" formatında şuan zaman bilgisi "date" içindeki parametreye ayarlanarak ServerUrl + "desired-temp" adresine oluşturulan json post metoduyla gönderilir.
