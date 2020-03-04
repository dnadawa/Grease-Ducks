import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grease_ducks/verify/password-change.dart';
import 'package:grease_ducks/widgets/text.dart';
import 'package:grease_ducks/widgets/toast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mysql1/mysql1.dart' show ConnectionSettings, MySqlConnection;

class VerifyEmail extends StatelessWidget {
  TextEditingController email = TextEditingController();
var code;

  sendMail(String code,BuildContext context) async {
    String username = 'greaseducks6@gmail.com';
    String password = 'Grease@123';

    final smtpServer = gmail(username, password);
    // Create our message.
    final message = Message()
      ..from = Address(username, 'Grease Ducks')
      ..recipients.add(email.text)
      ..subject = 'Reset Your Password'
      ..text = 'Your password reset code for Grease Ducks is $code';

    try {
      final sendReport = await send(message, smtpServer);
      ToastBar(text: 'Password Reset Code is Sent to your email',color: Colors.green).show();
      print('Message sent: ' + sendReport.toString());

      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => TypeVerifyCode(vCode: code.toString(),email: email.text,)),
      );



    } on MailerException catch (e) {
      ToastBar(text: 'Data Not Sent',color: Colors.red).show();
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  getData(BuildContext context) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'greaseducks.com',
        port: 3306,
        user: 'grease_gdt',
        password: 'Yq4aOB9;NANh',
        db: 'grease_gd'));
    var results = await conn.query("SELECT * FROM gd_contacts WHERE email='${email.text}' LIMIT 1");
    if (results.isNotEmpty) {
        Random rnd = Random();
        code = rnd.nextInt(99999999);
        print(code);

        sendMail(code.toString(),context);
    }
    else{

      ToastBar(text: 'User Doesn\'t exists!',color: Colors.red).show();
    }

    // Finally, close the connection
    await conn.close();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/back.jpg'),
              fit: BoxFit.cover),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Label(text: 'Forgot Password',size: 20,color: Colors.orange,align: TextAlign.center,),

            Padding(
              padding: const EdgeInsets.all(40),
              child: CupertinoTextField(
                cursorColor: Colors.green,
                padding: EdgeInsets.fromLTRB(10,15,10,15),
                keyboardType: TextInputType.emailAddress,
                controller: email,
                placeholder: 'Email',
                placeholderStyle: TextStyle(color: Colors.black),
                suffix: IconButton(icon: Icon(CupertinoIcons.forward), onPressed: ()=>getData(context),
              ),
            )
            )
          ],
        )
        ),

      );
  }
}








class TypeVerifyCode extends StatelessWidget {
final String vCode,email;
  TextEditingController code = TextEditingController();

   TypeVerifyCode({Key key, this.vCode, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/back.jpg'),
                fit: BoxFit.cover),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Label(text: 'Password reset code has sent to your email',size: 20,color: Colors.orange,align: TextAlign.center,),

              Padding(
                  padding: const EdgeInsets.all(40),
                  child: CupertinoTextField(
                    cursorColor: Colors.green,
                    padding: EdgeInsets.fromLTRB(10,15,10,15),
                    keyboardType: TextInputType.number,
                    controller: code,
                    placeholder: 'Verification Code',
                    placeholderStyle: TextStyle(color: Colors.black),
                    suffix: IconButton(icon: Icon(CupertinoIcons.forward), onPressed: (){
                      if(vCode == code.text){
                            print('code match');
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => PasswordChange(email: email,)),
                            );
                      }else{
                        ToastBar(text: 'Code Doesn\'t match',color: Colors.red).show();
                      }
                    },
                    ),
                  )
              )
            ],
          )
      ),

    );
  }
}












