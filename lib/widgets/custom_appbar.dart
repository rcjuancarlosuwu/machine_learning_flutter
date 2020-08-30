import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key key})
      : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  CustomAppBarState createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 24,
        ),
        Container(
            height: 56.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor,
                  blurRadius: 10.0,
                  spreadRadius: 0.5,
                  offset: Offset(
                    0,
                    0.5,
                  ),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  child: Image.asset('assets/images/applogo.png'),
                  padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                ),
                Padding(
                  child: Text("Easy Machine Learning",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).indicatorColor)),
                  padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                ),
                Padding(
                  child: InkWell(
                      child: Icon(Icons.menu),
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                      }),
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                ),
              ],
            )),
      ],
    );
  }
}
