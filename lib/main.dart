import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:secure_communication_mobile/pages/account.dart';
import 'package:secure_communication_mobile/pages/conversation.dart';
import 'package:secure_communication_mobile/pages/menu.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'firebaseNotification/fireNotification.dart';
void main() async{
  //WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.removeAfter(initialization);
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initialization(null);
  runApp(MaterialApp(
    theme: ThemeData(
        primaryColor: Color(0xFF3FAAD9)
    ),
    initialRoute: '/',
    routes: {
      '/':(context)=>Account(),
      '/menu':(context)=>Menu(),
      '/conv':(context)=>Conversation()
    },
  ));
}
Future initialization(BuildContext? context)async{
  await Future.delayed(Duration(seconds: 2));
  FlutterNativeSplash.remove();
}
