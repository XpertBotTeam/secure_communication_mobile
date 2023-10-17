import 'package:secure_communication_mobile/pages/calls.dart';
import 'package:flutter/material.dart';
import 'package:secure_communication_mobile/pages/chat.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<ScreenHiddenDrawer> pages=[];
  @override
  void initState(){
    super.initState();
    pages=[
      ScreenHiddenDrawer(ItemHiddenMenu(
          name: 'Friends',
          baseStyle: TextStyle(fontSize: 20),
          selectedStyle: TextStyle(fontSize: 20,color: Color(0xFF5181FF))
      ), Chats()),
      ScreenHiddenDrawer(ItemHiddenMenu(
          name: 'Friend Requests',
          baseStyle: TextStyle(fontSize: 20),
          selectedStyle: TextStyle(fontSize: 20,color: Color(0xFF5181FF))
      ), Calls()),
      ScreenHiddenDrawer(ItemHiddenMenu(
          name: 'Log out',
          baseStyle: TextStyle(fontSize: 20),
          selectedStyle: TextStyle(fontSize: 20,color: Color(0xFF5181FF))
    ,onTap: () async {
    await logout();
    }),
        Placeholder()
      ),
      /*ScreenHiddenDrawer(ItemHiddenMenu(
          name: 'logout',
          baseStyle: TextStyle(),
          selectedStyle: TextStyle()
      ), (){
        print("Log out");
      } as Widget)*/
    ];
  }
  Future<void> logout() async {
    final inist=await SharedPreferences.getInstance();
    inist.setString("token", "");
    Navigator.pushReplacementNamed(context, '/');
  }
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(screens: pages, backgroundColorMenu: Color(0xccA549FC),initPositionSelected: 0,);
  }
}
