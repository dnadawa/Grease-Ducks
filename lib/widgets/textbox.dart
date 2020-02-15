import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final textStyle = TextStyle(
  color: Colors.black,
);

class InputField extends StatelessWidget {

  final String hint;
  final TextInputType type;
  final bool ispassword;
  final TextEditingController controller;
  final Function onTap;

  const InputField({Key key, this.hint, this.type, this.ispassword=false, this.controller, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: CupertinoTextField(
        style: textStyle,
        cursorColor: Colors.green,
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        keyboardType: type,
        controller: controller,
        obscureText: ispassword,
        placeholder: hint,
        placeholderStyle: TextStyle(color: Colors.black),
        suffix: ispassword?IconButton(icon: Icon(CupertinoIcons.forward), onPressed: ()=>onTap()):null,
      ),
    );
  }
}