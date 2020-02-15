import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Label extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final TextAlign align;

  const Label({Key key, this.text='', this.size=14, this.color=Colors.black, this.align=TextAlign.start}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.bold,
          color: color
      ),
      textAlign: align,
    );
  }
}
