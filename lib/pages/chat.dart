import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}
TextEditingController Dc=new TextEditingController();
class _ChatsState extends State<Chats> {
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
                      }, icon: Icon(Icons.phone)),
                        IconButton(onPressed: () {
                          Navigator.pushNamed(context, '/conv',arguments: {
                            "id": k['id'],
                            "name": k['name'],
                            "token": tkToken
                          });
                        }, icon: Icon(Icons.chat_bubble))],mainAxisAlignment: MainAxisAlignment.end,))],
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
        title: Text("Enter your key"),
        content: TextField(decoration: InputDecoration(hintText: "KEY"),
          controller: Dc,),
        actions: [TextButton(onPressed: (){
          redeemApi(201720142,Dc.text);
          Navigator.of(context).pop();
        },
            child: Text("SUBMIT"))],
      ));
  Future<String> redeemApi(int uid,String token) async {
    Map bd={
      "id":uid,
      "token":token,
      "name":"device"
    };
    try{
      var response =await http.post(Uri.parse("https://6atjrezq36.execute-api.us-east-1.amazonaws.com/redeem"),
        body:json.encode(bd),
      );
      Map data=json.decode(response.body);
      if(data['code']==200) {
        showAlertDialog(context, "SUCCESS", "New friend was added");
      }
      else
        showAlertDialog(context,"ERROR","Key does not exist ");
    }catch(e){
      showAlertDialog(context,"No Internet","Check your internet connection.");
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
      var response =await http.get(Uri.parse("https://scmp.xpertbotacademy.online/api/getFriends"),
          headers: <String,String>{
            "Authorization": tkToken,
            "User-Agent": "Your User Agent",  // Replace with your user agent
            "Accept": "application/json",      // Set the appropriate Accept header
            "Content-Type": "application/json", // Set the appropriate Content-Type header
            "Accept-Encoding": "gzip",         // Set the appropriate Accept-Encoding header
          });
      data=json.decode(response.body);
      setState(() {
        alldev=data["friends"];
        p=1;
      });
    }catch(e){
      try{
        loadDev();
      }catch(e){
      showAlertDialog(context,"No Internet",e.toString());
      }
    }

  }
  Future<void> deleteAPI(String email) async {
    Map bd={
      "email":""
    };
    try{
      var response =await http.post(Uri.parse("https://ee15wx3t58.execute-api.us-east-1.amazonaws.com/deleteDev"),
        body:json.encode(bd),
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