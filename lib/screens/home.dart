import 'package:flutter/material.dart';
import 'package:machine_learning/util/info.dart';
import 'package:machine_learning/widgets/horizontal_place_item.dart';
import 'package:machine_learning/widgets/vertical_place_item.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "¡Bienvenido, usa nuestros ejemplos!",
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.all(20.0),
        //   child: Text(
        //     "Firebase Vision",
        //     style: TextStyle(
        //       fontSize: 15.0,
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        // ),
        // buildHorizontalList(context),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "Teacheable Machine",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        buildVerticalList(),
      ],
    );
  }

  buildHorizontalList(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 20.0),
      height: 260.0,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: firebase == null ? 0.0 : firebase.length,
        itemBuilder: (BuildContext context, int index) {
          Map option = firebase[index];
          return HorizontalPlaceItem(option: option);
        },
      ),
    );
  }

  buildVerticalList() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: teacheable == null ? 0 : teacheable.length,
        itemBuilder: (BuildContext context, int index) {
          Map option = teacheable[index];
          return VerticalPlaceItem(option: option);
        },
      ),
    );
  }
}
