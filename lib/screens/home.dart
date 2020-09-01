import 'package:flutter/material.dart';
import 'package:machine_learning/util/info.dart';
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
