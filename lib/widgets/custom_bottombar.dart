import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_learning/widgets/popup.dart';
import 'package:url_launcher/url_launcher.dart';

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
                                SizedBox(
                                  height: 50,
                                ),
                                Image.asset(
                                  "assets/images/github_logo.png",
                                  scale: 2,
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  "Todo el código se encuentra en nuestro repositorio, cada parte fundamental se encuentra documentado.",
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                InkWell(
                                  child: Text(
                                    "Ver código",
                                    style: TextStyle(
                                        color: Colors.blueAccent, fontSize: 16),
                                  ),
                                  onTap: () async {
                                    const url =
                                        'https://github.com/JuanCarlosRC/machine_learning_flutter';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                )
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
