import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grease_ducks/login.dart';
import 'package:grease_ducks/widgets/text.dart';
import 'package:grease_ducks/widgets/toast.dart';
import 'package:mysql1/mysql1.dart';


class PasswordChange extends StatelessWidget {

  final String email;

  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  PasswordChange({Key key, this.email}) : super(key: key);

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
              Label(text: 'Type your new password',size: 20,color: Colors.orange,align: TextAlign.center,),

              Padding(
                  padding: const EdgeInsets.fromLTRB(40,40,40,0),
                  child: CupertinoTextField(
                    cursorColor: Colors.green,
                    padding: EdgeInsets.fromLTRB(10,15,10,15),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    controller: password,
                    placeholder: 'New Password',
                    placeholderStyle: TextStyle(color: Colors.black),
                  )
              ),

              Padding(
                  padding: const EdgeInsets.fromLTRB(40,10,40,0),
                  child: CupertinoTextField(
                    cursorColor: Colors.green,
                    padding: EdgeInsets.fromLTRB(10,15,10,15),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    controller: confirmpassword,
                    placeholder: 'Confirm Password',
                    placeholderStyle: TextStyle(color: Colors.black),
                    suffix: IconButton(icon: Icon(CupertinoIcons.forward), onPressed: () async {

                      if(password.text == confirmpassword.text){
                        //save password
                       try{
                         final conn = await MySqlConnection.connect(ConnectionSettings(
                             host: 'greaseducks.com',
                             port: 3306,
                             user: 'grease_gdt',
                             password: 'Yq4aOB9;NANh',
                             db: 'grease_gd'));

                         await conn.query("UPDATE gd_contacts SET password='${password.text}' WHERE email='$email'");
                         ToastBar(text: 'Password successfully updated!',color: Colors.green).show();

                         Navigator.pushReplacement(
                           context,
                           CupertinoPageRoute(builder: (context) => LogIn()),
                         );

                       }
                       catch(e){
                         ToastBar(text: 'Something went wrong',color: Colors.red).show();
                       }
                      }
                      else{
                        ToastBar(text: 'Password don\'t match',color: Colors.red).show();
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