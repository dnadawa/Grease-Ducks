import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart' show ConnectionSettings, MySqlConnection, Results;
import 'dart:math';
class Test extends StatefulWidget {
  final String id;

  const Test({Key key, this.id}) : super(key: key);
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  Results results;
  int rotation;
  Color color;
  bool x,y,z;
  getData(BuildContext context) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'greaseducks.com',
        port: 3306,
        user: 'grease_gdt',
        password: 'Yq4aOB9;NANh',
        db: 'grease_gd'));

    // Query the database using a parameterized query
    results = await conn.query("SELECT * FROM gd_services WHERE account_id='${widget.id}'");
    int llim,hlim;
    rotation = results.elementAt(0)['rotation'];
    DateTime next_day = results.elementAt(0)['next_service'];
    DateTime last_dat = results.elementAt(0)['last_service'];
    int ret = next_day.difference(last_dat).inDays;
    switch(rotation){
      case 30:
        llim = -7;
        hlim = 7;
        break;
      case 60:
        llim = -15;
        hlim = 15;
        break;
      case 90:
        llim = -15;
        hlim = 15;
        break;
      case 120:
        llim = -30;
        hlim = 30;
        break;
      case 180:
        llim = -30;
        hlim = 30;
        break;
      case 360:
        llim = -30;
        hlim = 30;
        break;
    }


    if(ret < llim){
      setState(() {
        color = Colors.red;
        x= true;

      });
      }
    else if(ret >= llim && ret<=hlim){setState(() {
      color = Colors.orange;
      y = true;
    });}
    else if(ret > hlim){
      setState(() {
        color = Colors.blue;
        z=true;
      });
    }


//    if (results.isNotEmpty) {
//      var row = results.elementAt(0);
//
//      var user_name = row['username'];
//      var psswd = row['password'];
//      var fname = row['first_name'];
//      var lname = row['last_name'];
//    }

    // Finally, close the connection
    //await conn.close();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Hi',style: TextStyle(color: x==true?Colors.red:Colors.black),),
            Text('Hi',style: TextStyle(color: y==true?Colors.red:Colors.black),),
            Text('Hi',style: TextStyle(color: z==true?Colors.red:Colors.black),),
          ],
        ),
      ),
    );
  }
}
