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
                    "¿Quieres ver el código fuente?",
                    style: TextStyle(color: Theme.of(context).indicatorColor),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        PopUp(
                            header: "Recursos",
                            subheader: "",
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/github_logo.png",
                                ),
                                Text(
                                    "Todo el código se encuentra en nuestro repositorio, cada parte fundamental se encuentra documentado."),
                              ],
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
