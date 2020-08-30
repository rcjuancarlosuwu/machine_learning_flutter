import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopUp extends ModalRoute {
  Widget content;
  String header;
  String subheader;

  PopUp({this.header, this.subheader, this.content});

  Color bgColor;

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor =>
      bgColor == null ? Colors.black.withOpacity(0.5) : bgColor;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Material(
        type: MaterialType.transparency,
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Container(
      child: popupContent(context),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }

  Widget popupContent(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    var side = width * 0.14;
    var top = height * 0.09;
    return Container(
        margin: EdgeInsets.fromLTRB(side, top, side, top),
        padding: EdgeInsets.fromLTRB(16, 24, 0, 24),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: SingleChildScrollView(
          child: getCreditsContent(context),
        ));
  }

  Widget getCreditsContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(header,
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).indicatorColor,
                    fontWeight: FontWeight.w500)),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 24, 0),
                child: Icon(Icons.close))
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 32, 0, 0),
          child: Text(subheader,
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).indicatorColor,
                  fontWeight: FontWeight.w500)),
        ),
        SingleChildScrollView(child: content),
      ],
    );
  }
}
