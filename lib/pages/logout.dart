import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
class Logout extends StatefulWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {

    @override
    void initState(){
      super.initState();
      out();
    }
    return const Placeholder();
}

  Future<void> out() async {
    final inist=await SharedPreferences.getInstance();
    inist.setString("token", "");
    Navigator.pushReplacementNamed(context, '/');
  }
}
