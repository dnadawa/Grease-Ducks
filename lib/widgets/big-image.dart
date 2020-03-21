import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BigImage extends StatelessWidget {
  final String url;

  const BigImage({Key key, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(url),
      ),
    );
  }
}
