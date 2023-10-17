import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
class Conversation extends StatefulWidget {
  const Conversation({Key? key}) : super(key: key);

  @override
  State<Conversation> createState() => _ConversationState();
}
class Message{
  String txt="",from="",txtLink="",rating="",descr="",ttl="";
  DateTime date=DateTime.now().subtract(Duration(minutes: 1));
  Message(this.txt, this.from, [String? dt]) {
    if (dt != null) {
      date = DateTime.parse(dt);
    } else {
      date = DateTime.now().subtract(Duration(minutes: 1));
    }
  }
}
TextEditingController cm=new TextEditingController();
String removeFirst<String>(List<String> list) {
  if (list.isEmpty) {
    throw Exception('List is empty');
  }

  return list.removeAt(0);
}

class _ConversationState extends State<Conversation> {
  Map data = {};
  bool stopLoop = false;
  List<Timer> allT=[];
  List<Message> messages = [];
  String tkToken="";
  bool f = true;
  bool isListen = false;
  bool pro=true;
  @override
  void initState() {
    super.initState();
    // Delay the retrieval of the argument until the widget is built
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Map t=ModalRoute
          .of(context)
          ?.settings
          ?.arguments as Map;
      tkToken = t['token'];
      getMessages(t['id'].toString());
      updateMessages(t['id'].toString());
      // Perform any actions that require tkToken here
      print("token: "+tkToken);
    });

  }
  bool isFormedFromPattern(String input) {
    RegExp pattern = RegExp(r'^(A|J)\d+$');
    return pattern.hasMatch(input);
  }
  List<dynamic> getElements(String s1){
    List<dynamic> testResult = [];
    if(isFormedFromPattern(s1)){
      testResult.add(s1[0]);
      testResult.add(s1.substring(1));
      return testResult;
    }
    else
      return ["N",-1];
  }
  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Location permissions are granted, you can use the geolocator package now.
    } else {
      // Handle the case where the user denied location permissions.
    }
  }
  Future<String> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double latitude = position.latitude;
    double longitude = position.longitude;

    return 'Latitude: $latitude, Longitude: $longitude';
  }
  @override
  Widget build(BuildContext context) {
    data = ModalRoute
        .of(context)
        ?.settings
        ?.arguments as Map;
    if (f == true) {

      f = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(data["name"]), // Replace with your app title
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back button icon
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(child: GroupedListView<Message, DateTime>(
            padding: const EdgeInsets.all(8),
            reverse: true,
            order: GroupedListOrder.DESC,
            useStickyGroupSeparators: true,
            floatingHeader: true,
            elements: messages.length >= 20 ? messages.sublist(
                messages.length - 20) : messages,
            groupBy: (message) =>
                DateTime(
                  message.date.year,
                  message.date.month,
                  message.date.day,
                ),
            groupHeaderBuilder: (Message message) =>
                SizedBox(
                  height: 40,
                  child: Center(
                    child: Card(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          DateFormat.yMMMd().format(message.date),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
            itemBuilder: (context, Message message) =>
                Align(
                  alignment: message.from == "me"
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                        _copyToClipboard(message.txt);
                    },
                    child: Card(
                      elevation: 8,
                      color: message.from == "me" ? Color(0xFF5181EF) : Color(
                          0xFFA549FC),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          message.txt, style: TextStyle(
                          color: Color(0xFFCAD5E3),
                          fontSize: 15,
                        ),)
                      ),
                    ),
                  ),
                ),
          ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Color(0x8036F7C5),
                boxShadow: [BoxShadow(
                    color: Color(0xccA549FC),
                    blurRadius: 6,
                    offset: Offset(0, 2)
                )
                ]
            ),
            height: 60,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(children: [
                Flexible(
                  child: TextField(
                    controller: cm,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        color: Color(0xFF5181EF),
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14, bottom: 20),
                        hintText: 'type your message',
                        hintStyle: TextStyle(
                            color: Color(0xFF5181EF)
                        )
                    ),
                    onSubmitted: (text) {
                      final message = Message(text, "me");
                      setState(() => messages.add(message));
                      sendDelta(text,data["id"].toString());
                      cm.text = "";
                    },
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      try{
                        cm.text=await getLocation();
                      }catch(e){
                        requestLocationPermission();
                      }
                    },
                    icon: Icon(
                      Icons.location_on, // You can replace this with your desired icon
                      color: Color(0xFF5181EF),
                      size: 40,
                    )),
                IconButton(
                  onPressed: () {
                    sendDelta(cm.text, data["id"].toString());
                    setState(() {
                      messages.add(Message(cm.text, "me"));
                      cm.text="";
                    });
                  },
                  icon: Icon(
                    Icons.send, // You can replace this with your desired icon
                    color: Color(0xFF5181EF),
                    size: 40,
                  ),
                ),


              ],
              ),
            ),
          )

        ],
      ),
    );
  }

  Future<void> sendDelta(String mess,String ide) async {
    Map bd={
      "message": mess
    };
    try{
      var response =await http.post(Uri.parse("https://scmp.xpertbotacademy.online/api/sendMessage/"+ide),
          body:json.encode(bd),
          headers: <String,String>{
            "Authorization": tkToken,
            "User-Agent": "Your User Agent",  // Replace with your user agent
            "Accept": "application/json",      // Set the appropriate Accept header
            "Content-Type": "application/json", // Set the appropriate Content-Type header
            "Accept-Encoding": "gzip",         // Set the appropriate Accept-Encoding header
          }
      );
      //showAlertDialog(context,"No Internet",response.body);
    }catch(e){
      print("____+"+e.toString());
      showAlertDialog(context,"No Internet","Check your internet connection.");
    }

  }
  Future<void> updateMessages(String ide) async {
    while (pro) {
      if (mounted) {
        getMessages(ide);
        await Future.delayed(Duration(seconds: 5));
      } else {
        break; // Exit the loop if the widget is disposed
      }
    }
  }

  Future<void> getMessages(String ide) async {
    try{
      var response =await http.get(Uri.parse("https://scmp.xpertbotacademy.online/api/showMessage/"+ide),
          headers: <String,String>{
            "Authorization": tkToken,
            "User-Agent": "Your User Agent",  // Replace with your user agent
            "Accept": "application/json",      // Set the appropriate Accept header
            "Content-Type": "application/json", // Set the appropriate Content-Type header
            "Accept-Encoding": "gzip",         // Set the appropriate Accept-Encoding header
          }
      );
      List<Map<String, dynamic>> LM = List<Map<String, dynamic>>.from(json.decode(response.body));
      setState(() {
        messages=[];
        for(Map<String,dynamic> lm in LM){
          messages.add(Message(lm["Content"],lm["RecipientID"]!=data["id"]?"delta":"me",lm["Timestamp"] ));
        }
      });
    }catch(e){
      print("____+"+e.toString());
      showAlertDialog(context,"No Internet","Check your internet connection.");
    }

  }
  void showAlertDialog(BuildContext context, String ttle,String message){
    Widget okButton=TextButton(onPressed: (){
      setState(() {
        pro=false;
      });
      Navigator.of(context).pop();
    }, child: Text("Okay"));
    AlertDialog alert=AlertDialog(title: Text(ttle),content: Text(message),
      actions: [okButton],);
    showDialog(context: context, builder: (BuildContext context){
      return alert;
    });
  }
  void _copyToClipboard(String text) {
    FlutterClipboard.copy(text).then((result) {
      final snackBar = SnackBar(
        content: Text('Text copied to clipboard'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
