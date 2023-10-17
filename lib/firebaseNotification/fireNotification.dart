import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}
Future<void> setToken(String tkT,String tkToken) async {
  Map bd={
    "new_token": tkT,
  };
  try{
    var response =await http.post(Uri.parse("https://scmp.xpertbotacademy.online/api/setToken"),
        body: json.encode(bd),
        headers: <String,String>{
          "Authorization": tkToken,
          "User-Agent": "Your User Agent",  // Replace with your user agent
          "Accept": "application/json",      // Set the appropriate Accept header
          "Content-Type": "application/json", // Set the appropriate Content-Type header
          "Accept-Encoding": "gzip",         // Set the appropriate Accept-Encoding header
        }
    );
    print("response: "+response.body.toString());
  }catch(e){
    print("____+"+e.toString());

  }

}
class FirebaseApi{
  final _firebaseMessaging=FirebaseMessaging.instance;
  Future<void> initNotification(String S) async{
    await _firebaseMessaging.requestPermission();
    final fCMToken=await _firebaseMessaging.getToken();
    setToken(fCMToken!, S);
    print('Notification token: $fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}