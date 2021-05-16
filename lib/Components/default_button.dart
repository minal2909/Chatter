import 'package:chatter_app/Utilities/constants.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    @required this.size,
    this.label,
    this.press,
  }) : super(key: key);

  final Size size;
  final String label;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.all(kDefaultPadding),
      child: RaisedButton(
        onPressed: press,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        textColor: Colors.white,
        padding: EdgeInsets.all(0),
        child: Container(
          alignment: Alignment.center,
          height: 50.0,
          width: size.width * 0.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 255, 136, 34),
                Color.fromARGB(255, 255, 177, 41)
              ])),
          padding: EdgeInsets.all(0),
          child: Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 1)),
        ),
      ),
    );
  }
}
