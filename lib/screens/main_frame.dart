import 'package:flutter/material.dart';
import 'package:machine_learning/screens/credits.dart';
import 'package:machine_learning/screens/home.dart';
import 'package:machine_learning/widgets/custom_appbar.dart';
import 'package:machine_learning/widgets/custom_bottombar.dart';

class MainFrame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainFrameState();
}

class MainFrameState extends State<MainFrame> {
  int _selectedDrawerIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      endDrawer: getDrawer(context), // Drawer
      body: _getDrawerItemWidget(_selectedDrawerIndex),
      bottomNavigationBar: BottomBar(),
    );
  }

  // Options
  _getDrawerItemWidget(int position) {
    switch (position) {
      case 1:
        return Home();
      case 2:
        return Home();
      case 3:
        return Credits();
    }
  }

  // Drawer
  Drawer getDrawer(BuildContext context) {
    return Drawer(
        child: Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  child: Image.asset("assets/images/applogo.png"),
                  curve: Curves.fastLinearToSlowEaseIn,
                ),
                drawerOption(1, "Inicio"),
                // drawerOption(2, "Configuraciones"),
                drawerOption(3, "Créditos"),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/fis_logo.png",
                      scale: 8.5,
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(
                          color: Theme.of(context).indicatorColor,
                          fontSize: 10,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Facultad de Ingeniería de Sistemas\n"),
                          TextSpan(text: "Versión 1.0"),
                        ]),
                  )
                ],
              ))
        ],
      ),
    ));
  }

  Widget drawerOption(int number, String name) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32), bottomLeft: Radius.circular(32))),
        color: _selectedDrawerIndex == number
            ? Theme.of(context).backgroundColor
            : Theme.of(context).primaryColor,
        textColor: Theme.of(context).indicatorColor,
        disabledColor: Colors.grey,
        disabledTextColor: Theme.of(context).indicatorColor,
        padding: EdgeInsets.all(12.0),
        splashColor: Colors.grey,
        onPressed: () {
          setState(() => _selectedDrawerIndex = number);
          Navigator.of(context).pop(); // close the drawer
        },
        child: Text(
          name,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
