import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../firebaseNotification/fireNotification.dart';
class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}
TextEditingController cf=new TextEditingController();
TextEditingController cl=new TextEditingController();
TextEditingController ce=new TextEditingController();
TextEditingController cp=new TextEditingController();
Widget buildEmail(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Email',
        style: TextStyle(
            color: Color(0xccA549FC),
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(height: 10,),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color:Color(0x8036F7C5),
            boxShadow: [BoxShadow(
                color:Color(0xccA549FC),
                blurRadius: 6,
                offset: Offset(0,2)
            )
            ]
        ),
        height: 60,
        child: TextField(
          controller: ce,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              color: Color(0xFF5181EF),
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14,bottom: 20),
              prefixIcon: Icon(
                Icons.account_box,
                color: Color(0xccA549FC),
              ),
              hintText: 'Email',
              hintStyle: TextStyle(
                  color: Color(0xFF5181EF)
              )
          ),
        ),
      )
    ],
  );

}
Widget buildPassword() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Password',
        style: TextStyle(
            color: Color(0xccA549FC),
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(height: 10,),
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
        child: TextField(
          controller: cp,
          obscureText: true,
          style: TextStyle(
              color: Color(0xFF5181EF),
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, bottom: 20),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xccA549FC),
              ),
              hintText: 'password',
              hintStyle: TextStyle(
                  color: Color(0xFF5181EF)
              )
          ),
        ),
      )
    ],
  );
}
Widget buildFName() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('First Name',
        style: TextStyle(
            color: Color(0xccA549FC),
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(height: 10,),
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
        child: TextField(
          controller: cf,
          obscureText: false,
          style: TextStyle(
              color: Color(0xFF5181EF),
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, bottom: 20),
              prefixIcon: Icon(
                Icons.person,
                color: Color(0xccA549FC),
              ),
              hintText: 'First Name',
              hintStyle: TextStyle(
                  color: Color(0xFF5181EF)
              )
          ),
        ),
      )
    ],
  );
}
Widget buildLName() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Last Name',
        style: TextStyle(
            color: Color(0xccA549FC),
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(height: 10,),
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
        child: TextField(
          controller: cl,
          obscureText: false,
          style: TextStyle(
              color: Color(0xFF5181EF),
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, bottom: 20),
              prefixIcon: Icon(
                Icons.account_box,
                color: Color(0xccA549FC),
              ),
              hintText: 'Last Name',
              hintStyle: TextStyle(
                  color: Color(0xFF5181EF)
              )
          ),
        ),
      )
    ],
  );
}


class _AccountState extends State<Account>{
  Map data={};
  int a=1;
  bool loadig=false;
  String namo='';
  bool isDataInitialized = false;
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      namo = await _getToken() as String;
      if (namo != "") {
        final bool tokenVerified = await verifyToken(namo);
        if (tokenVerified) {
          await Firebase.initializeApp();
          await FirebaseApi().initNotification(namo);
          Navigator.pushReplacementNamed(context, '/menu',arguments: namo);
        }
      }
      setState(() {
        isDataInitialized=true;
      });
    } catch (e) {
      print('Error in _initializeData: $e');
      // You can also display the error using your showAlertDialog method
      // showAlertDialog(context, "Error", e.toString());
    }finally{
      setState(() {
        isDataInitialized=true;
      });
    }
  }
  Widget build(BuildContext context){
    //Here

    if(a%2==0)
      return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            child: Stack(
              children: <Widget>[
                Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0x66D2D9FA),
                              Color(0x99D2D9FA),
                              Color(0xccD2D9FA),
                              Color(0xffD2D9FA),
                            ]
                        )
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25,vertical: 120
                      ),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Sign UP",
                            style: TextStyle(
                                color: Color(0xccA549FC),
                                fontSize: 40,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 20,),
                          buildEmail(),
                          SizedBox(height: 20,),
                          buildPassword(),
                          SizedBox(height: 20,),
                          buildFName(),
                          SizedBox(height: 20,),
                          buildLName(),
                          SizedBox(height: loadig?80:20,),
                          loadig?CircularProgressIndicator(color: Color(0xFF5181EF),):Container(
                            padding: EdgeInsets.symmetric(vertical: 25),
                            width: double.infinity,
                            child: ElevatedButton(onPressed: () {
                              if(cf.text==""||cl.text==""||ce.text==""||cp.text==""){
                                showAlertDialog(context,"Error","Some of the fields are missing");
                              }else{
                                createAccount(cf.text, cl.text, ce.text, cp.text);
                              }
                            },
                              style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  padding: EdgeInsets.all(15),
                                  backgroundColor: Color(0xFF5181EF)
                              ),
                              child:Text("Sign UP",
                                style: TextStyle(
                                    color: Color(0xffD2EEFA)
                                ),) ,),

                          )
                          ,
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          setState(() {
            a++;
          });
        },
        label: Text("Sign IN",style: TextStyle(
            color: Color(0xFF4E3FD9)
        ),),
        icon: Icon(Icons.login,color: Color(0xFF4E3FD9),),
        backgroundColor: Color(0xFF5181EF),
      ),

      );
    else if(a%2==1)
      return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            child: Stack(
              children: <Widget>[
                Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0x66D2D9FA),
                              Color(0x99D2D9FA),
                              Color(0xccD2D9FA),
                              Color(0xffD2D9FA),
                            ]
                        )
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25,vertical: 120
                      ),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Sign IN",
                            style: TextStyle(
                                color: Color(0xccA549FC),
                                fontSize: 40,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 20,),
                          buildEmail(),
                          SizedBox(height: 20,),
                          buildPassword(),
                          SizedBox(height: 20,),
                          loadig?CircularProgressIndicator(color: Color(0xFF5181EF),):
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 25),
                            width: double.infinity,
                            child: ElevatedButton(onPressed: () {
                              if(loadig==false){
                                if(ce.text==""||cp.text=="")
                                  showAlertDialog(context,"ERROR","Some of the fields are missing");
                                else

                                  login(ce.text, cp.text);

                              }},
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                padding: EdgeInsets.all(15),
                                backgroundColor: Color(0xFF5181EF),
                              ),
                              child:Text("Sign IN",
                                style: TextStyle(
                                    color: Color(0xffD2EEFA)
                                ),) ,),

                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        )
        ,floatingActionButton: this.namo!=""?FloatingActionButton.extended(
        onPressed: (){
          setState(() {
            a++;
          });

        },
        label: Text("SignUP",style: TextStyle(
            color: Color(0xFF4E3FD9)
        ),),
        icon: Icon(Icons.app_registration,color: Color(0xFF4E3FD9),),
        backgroundColor: Color(0xFF5181EF),
      ):FloatingActionButton.extended(onPressed: (){setState(() {
        a++;
      });},label: Text("Sign Up"),),
      );
    else{
      return Center(
        child: CircularProgressIndicator(), // Replace with your splash screen UI
      );
    }
  }
  Future<String> _getToken() async{
    final inist = await SharedPreferences.getInstance();
    String name1 = inist.getString("token") ?? "";
    if(name1==null)
      name1= "";
    setState(() {
      namo=name1;
    });
    return name1;
  }
  Future<String> _getNu() async{
    return "";
  }
  Future<void> _setToken(String value) async{
    final inist=await SharedPreferences.getInstance();
    inist.setString("token", value);
  }
  Future<String> login(String email,String password) async {
    setState(() {
      loadig=true;
    });
    Map bd={
      "email": email,
      "password": password
    };
    try {
      var response =await http.post(Uri.parse("https://scmp.xpertbotacademy.online/api/login"),
        headers: {"Content-Type": "application/json"},
        body:json.encode(bd),
      );
      data=json.decode(response.body);
      if(data['status']){
        //to do after
        _setToken("Bearer "+data['token']);
        await Firebase.initializeApp();
        await FirebaseApi().initNotification("Bearer "+data['token']);
        Navigator.pushReplacementNamed(context, '/menu',arguments: "Bearer "+data['token']);
      }else{
        showAlertDialog(context,"ERROR","incorrect id or password");
      }
    }catch(e){
      showAlertDialog(context,"No Internet",e.toString());
    }
    return Future.delayed(Duration(seconds: 3),(){
      setState(() {

        loadig=false;

      });
      return "";
    });
  }
  Future<bool> verifyToken(String authorizationHeader) async {
    String url="https://scmp.xpertbotacademy.online/api/rememberMe";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Authorization': authorizationHeader,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      print('Error: $e');
      return false;
    }
  }
  Future<String> createAccount(String fname,String lname,String email,String password) async {
    setState(() {
      loadig=true;
    });
    Map bd={
      "name": fname+" "+lname,
      "email": email,
      "password": password
    };
    try{
      var response =await http.post(Uri.parse("https://scmp.xpertbotacademy.online/api/register"),
        headers: {"Content-Type": "application/json"},
        body:json.encode(bd),
      );
      data=json.decode(response.body);
      if(data['status']) {
        setState(() {
          a++;
        });
        showAlertDialog(context, "SUCCESS", "Please Sign in to your Account");
      }
      else
        showAlertDialog(context,"ERROR","Email already been used");
    }catch(e){
      showAlertDialog(context,"No Internet","Check your internet connection.");
      print(e.toString());
    }
    return Future.delayed(Duration(seconds: 3),(){
      setState(() {

        loadig=false;

      });
      return "";
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