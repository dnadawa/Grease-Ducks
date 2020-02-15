import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grease_ducks/widgets/text.dart';
import 'package:grease_ducks/widgets/textbox.dart';
import 'package:grease_ducks/widgets/toast.dart';
import 'package:mysql1/mysql1.dart' show ConnectionSettings, MySqlConnection;
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class LogIn extends StatelessWidget {


  TextEditingController uname = TextEditingController();
  TextEditingController password = TextEditingController();


  getData(BuildContext context) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'greaseducks.com',
        port: 3306,
        user: 'grease_gdt',
        password: 'Yq4aOB9;NANh',
        db: 'grease_gd'));

    // Query the database using a parameterized query
    var results = await conn.query("SELECT * FROM gd_contacts WHERE username='${uname.text}' LIMIT 1");
    if (results.isNotEmpty) {
      var row = results.elementAt(0);

      var user_name = row['username'];
      var psswd = row['password'];
      var fname = row['firstname'];
      var lname = row['lastname'];
      var uid = row['id'].toString();


      if(user_name==uname.text&&psswd==password.text){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('uid', uid);
        prefs.setString('uname', fname+' '+lname);
        print('User Logged In');
        await ToastBar(text: '${row['firstname']+' '+row['lastname']} logged in.',color: Colors.green).show();
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => HomePage(uname: fname+' '+lname,)),
        );
      }else{
        ToastBar(text: 'Username Or Password is Incorrect.',color: Colors.red).show();
      }


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
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/back.jpg'),
          fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.fromLTRB(50,0,50,50),
              child: Image.asset('images/logo.png'),
            ),

            Label(text: 'Welcome to Grease Ducks\nPlese Sign In',size: 20,color: Colors.orange,align: TextAlign.center,),

            Padding(
              padding: const EdgeInsets.fromLTRB(40,40,40,0),
              child: InputField(type: TextInputType.emailAddress,hint: 'Username',controller: uname),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: InputField(type: TextInputType.text,hint: 'Password',controller: password,ispassword: true,onTap: (){

                getData(context);},),
            ),


            Padding(
              padding: const EdgeInsets.all(30),
              child: Label(text: 'Forgot My Password',color: Colors.green,size: 18,),
            ),


            SizedBox(height: 140,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Label(text: 'Privacy Policy',color: Colors.white,),
                SizedBox(width: 10,),
                Label(text: '|',color: Colors.white,),
                SizedBox(width: 10,),
                Label(text: 'Terms & Conditions',color: Colors.white,)
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Label(text: '© 2020 Grease Ducks Inc. All Rights Reserved!',color: Colors.white,),
            )




          ],
        ),
      ),
    );
  }
}
