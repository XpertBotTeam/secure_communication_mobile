import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
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
          keyboardType: TextInputType.numberWithOptions(),
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
  @override
  Widget build(BuildContext context){
    //Here
    _getName();
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
    else
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
        ),floatingActionButton: this.namo!=""?FloatingActionButton.extended(
        onPressed: (){
          a=a+1;

        },
        label: Text("SignUP",style: TextStyle(
            color: Color(0xFF4E3FD9)
        ),),
        icon: Icon(Icons.app_registration,color: Color(0xFF4E3FD9),),
        backgroundColor: Color(0xFF5181EF),
      ):FloatingActionButton.extended(onPressed: (){},label: Text("Welcome"),),

      );
  }
  Future<String> _getName() async{
    final inist = await SharedPreferences.getInstance();
    String name1 = inist.getString("Fname") ?? "Default Name";
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
  Future<void> _setName(String value) async{
    final inist=await SharedPreferences.getInstance();
    inist.setString("Fname", value);
  }
  Future<String> login(String email,String password) async {
    setState(() {
      loadig=true;
    });
    login2(email,password);
    Map bd={
      "id": email,
      "pwd": password
    };
    try {
      var response = await http.post(Uri.parse(
          "https://n5eag73vbi.execute-api.us-east-1.amazonaws.com/seliFunction"),
        body: json.encode(bd),);
      data=json.decode(response.body);
      if(data['code']==200){
        data['id']=email;
        _setName("Carlos");
        Navigator.pushReplacementNamed(context, '/menu',arguments: data);
      }else{
        showAlertDialog(context,"ERROR","incorrect id or password");
      }
    }catch(e){
      showAlertDialog(context,"No Internet","Check your internet connection.");
    }
    return Future.delayed(Duration(seconds: 3),(){
      setState(() {

        loadig=false;

      });
      return "";
    });
  }
  Future<String> login2(String email,String password) async {
    Map bd={
      "uid": email,
      "upassword": password
    };
    try {
      var response = await http.post(Uri.parse(
          "https://spwy0ag0oe.execute-api.us-east-1.amazonaws.com/updateDB"),
        body: json.encode(bd),);
    }catch(e){
      showAlertDialog(context,"No Internet","Check your internet connection.");
    }
    return "";
  }
  Future<String> createAccount(String fname,String lname,String email,String password) async {
    setState(() {
      loadig=true;
    });
    Map bd={
      "fname":fname,
      "lname":lname,
      "email": email,
      "password": password
    };
    try{
      var response =await http.post(Uri.parse("https://3vj8wbi73j.execute-api.us-east-1.amazonaws.com/signupuser"),
        body:json.encode(bd),
      );
      data=json.decode(response.body);
      if(data['response']==200) {
        setState(() {
          a++;
        });
        showAlertDialog(context, "SUCCESS", "Please Sign in to your Account");
      }
      else
        showAlertDialog(context,"ERROR","Email already been used");
    }catch(e){
      showAlertDialog(context,"No Internet","Check your internet connection.");
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