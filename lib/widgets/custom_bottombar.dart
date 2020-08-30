import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_learning/widgets/popup.dart';

class BottomBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              height: 1,
              color: Theme.of(context).primaryColor,
            ),
            flex: 1,
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                InkWell(
                  child: Text(
                    "¿Necesitas Ayuda?",
                    style: TextStyle(color: Theme.of(context).indicatorColor),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        PopUp(
                            header: "Ayuda",
                            subheader: "",
                            content: Center(
                              child: Text("."),
                            )));
                  },
                ),
              ],
            ),
            flex: 99,
          )
        ],
      ),
    );
  }
}
