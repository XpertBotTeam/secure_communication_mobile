import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
class Calls extends StatefulWidget {
  const Calls({Key? key}) : super(key: key);

  @override
  State<Calls> createState() => _CallsState();
}
TextEditingController Dc=new TextEditingController();
class _CallsState extends State<Calls> {
  int p=0;
  List alldev=[];
  List <Widget> devs=[];
  String tkToken="";
  @override
  void initState() {
    super.initState();
    // Delay the retrieval of the argument until the widget is built
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      tkToken = ModalRoute.of(context)?.settings?.arguments as String;
      // Perform any actions that require tkToken here
      print("token: "+tkToken);
    });

  }
  Widget build(BuildContext context) {
    if(p==1) {
      if(alldev==[])
        return Scaffold(
          body: Center(child: Text("No Friend")),
          floatingActionButton: FloatingActionButton.extended(onPressed: () {
            openRedeem();
          }, label: Text("ADD Friend", style: TextStyle(
              color: Color(0xFFFFFFFF)
          ),), icon: Icon(Icons.add),),
        );
      else {
        devs=[];
        alldev.forEach((k) {
          if (k['name'] != 'wait')
            devs.add(Padding(
              padding: const EdgeInsets.fromLTRB(0,10,0,0),
              child: Container(
                child: Row(
                  children: [Expanded(child: Text("     "+k['name'],style: TextStyle(fontSize: 19),)), Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10, 0, 10),
                      child: Row(children: [IconButton(onPressed: () {
                        //Navigator.pushNamed(context, '/inputdev',arguments: alldev[key]);
                        acceptApi(k['email']);
                      }, icon: Icon(Icons.done)),
                        IconButton(onPressed: () {
                          deleteAPI(k['email']);
                        }, icon: Icon(Icons.phonelink_erase_rounded))],mainAxisAlignment: MainAxisAlignment.end,))],
                ),color: Color(0xccD2D9FA),
              ),
            ),);
          else
            devs.add(Text("Loading..."));
        });
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: SingleChildScrollView(child: Column(children: devs,)),
          ),
          floatingActionButton: FloatingActionButton.extended(onPressed: () {
            openRedeem();
          }, label: Text("ADD Friend", style: TextStyle(
              color: Color(0xFFFFFFFF)
          ),), icon: Icon(Icons.add),),
        );
      }
    }else {
      loadDev();
      return Scaffold(
        body: Center(child: Text("Please Wait...")),
        floatingActionButton: FloatingActionButton.extended(onPressed: () {
          openRedeem();
        }, label: Text("New Friend", style: TextStyle(
            color: Color(0xFFFFFFFF)
        ),), icon: Icon(Icons.add),),
      );
    }
  }

  Future openRedeem() =>showDialog(context: context,
      builder: (context)=>AlertDialog(
        title: Text("Add a Friend"),
        content: TextField(decoration: InputDecoration(hintText: "Email"),
          controller: Dc,),
        actions: [TextButton(onPressed: (){
          redeemApi(Dc.text);
          Navigator.of(context).pop();
        },
            child: Text("SUBMIT"))],
      ));
  Future<String> redeemApi(String email_) async {
    Map bd={
      "friend_email": email_
    };
    try{
      var response =await http.post(Uri.parse("https://scmp.xpertbotacademy.online/api/addFriend"),
        body:json.encode(bd),
          headers: <String,String>{
            "Authorization": tkToken,
            "User-Agent": "Your User Agent",  // Replace with your user agent
            "Accept": "application/json",      // Set the appropriate Accept header
            "Content-Type": "application/json", // Set the appropriate Content-Type header
            "Accept-Encoding": "gzip",         // Set the appropriate Accept-Encoding header
          }
      );

      print(response.body);
      Map data=json.decode(response.body);
      if(response.statusCode==200) {
        showAlertDialog(context, "SUCCESS", "Friend Request Sent");
      }
      else if(response.statusCode==400)
        showAlertDialog(context,"ERROR",data["message"]);
      else
        showAlertDialog(context,"ERROR",response.statusCode.toString());
    }catch(e){
      showAlertDialog(context,"No Internet",tkToken);
    }
    setState(() {
      p=0;
    });
    return Future.delayed(Duration(seconds: 3),(){

      return "";
    });
  }

  Future<void> loadDev() async {
    Map<String,dynamic> data={};
    try{
      var response =await http.get(Uri.parse("https://scmp.xpertbotacademy.online/api/getFriendRequests"),
      headers: <String,String>{
        "Authorization": tkToken,
        "User-Agent": "Your User Agent",  // Replace with your user agent
        "Accept": "application/json",      // Set the appropriate Accept header
        "Content-Type": "application/json", // Set the appropriate Content-Type header
        "Accept-Encoding": "gzip",         // Set the appropriate Accept-Encoding header
      });
      data=json.decode(response.body);
    }catch(e){
      try{
        loadDev();
      }catch(e){
        showAlertDialog(context,"No Internet",e.toString());
      }
    }

    setState(() {
      try{
        if(data["message"]=="No friend requests")
          alldev=[];
        else
          alldev=data["friend_requests"];
      }catch(e){
        loadDev();
      }
      p=1;
    });
  }
  Future<void> deleteAPI(String email) async {
    Map bd={
      "friend_email": email
    };
    try{
      var response =await http.post(Uri.parse("https://scmp.xpertbotacademy.online/api/rejectFriendRequest"),
          body:json.encode(bd),
          headers: <String,String>{
            "Authorization": tkToken,
            "User-Agent": "Your User Agent",  // Replace with your user agent
            "Accept": "application/json",      // Set the appropriate Accept header
            "Content-Type": "application/json", // Set the appropriate Content-Type header
            "Accept-Encoding": "gzip",         // Set the appropriate Accept-Encoding header
          }
      );

    }catch(e){
      print("____+"+e.toString());
      showAlertDialog(context,"No Internet","Check your internet connection.");
    }
    setState(() {
      p=0;
    });
  }
  Future<void> acceptApi(String email) async {
    Map bd={
      "friend_email": email
    };
    try{
      var response =await http.post(Uri.parse("https://scmp.xpertbotacademy.online/api/acceptFriend"),
        body:json.encode(bd),
          headers: <String,String>{
            "Authorization": tkToken,
            "User-Agent": "Your User Agent",  // Replace with your user agent
            "Accept": "application/json",      // Set the appropriate Accept header
            "Content-Type": "application/json", // Set the appropriate Content-Type header
            "Accept-Encoding": "gzip",         // Set the appropriate Accept-Encoding header
          }
      );
    }catch(e){
      print("____+"+e.toString());
      showAlertDialog(context,"No Internet","Check your internet connection.");
    }
    setState(() {
      p=0;
    });
  }
  void showAlertDialog(BuildContext context, String ttle,String message){
    Widget okButton=TextButton(onPressed: (){
      Navigator.of(context).pop();
    }, child: Text("Okay"));
    AlertDialog alert=AlertDialog(title: Text(ttle),content: Text(message),
      actions: [okButton],);
    showDialog(context: context, builder: (BuildContext context){
      return alert;
    });
  }
}