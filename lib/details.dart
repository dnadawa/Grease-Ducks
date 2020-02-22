import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grease_ducks/widgets/text.dart';
import 'package:mysql1/mysql1.dart' show ConnectionSettings, MySqlConnection, Results;

class Details extends StatefulWidget {
  final String hours;
  final String comName;
  final String uname;
  final String id;


  const Details({Key key, this.hours, this.comName, this.uname, this.id}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var line1,line2,city,zip;
Results results;
  getData(BuildContext context,String query) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'greaseducks.com',
        port: 3306,
        user: 'grease_gdt',
        password: 'Yq4aOB9;NANh',
        db: 'grease_gd'));

 results = await conn.query(query);
    for (var row in results) {
      if(row['name']=='line_1'){
        line1 = row['value'];
      }
      if(row['name']=='line_2'){
        line2 = row['value'];
      }
      if(row['name']=='city'){
        city = row['value'];
      }
      if(row['name']=='zip'){
        zip = row['value'];
      }
    }

    setState(() {});

    //print('line 1:$line1 \n line 2:$line2 \n city:$city \n zip:$zip');

    //await conn.close();
  }

  var sunS,sunE,monS,monE,tueS,tueE,wedS,wedE,thuS,thuE,friS,friE,satS,satE;
  var body;
  bool visible;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visible = true;
    getData(context, "SELECT name,value FROM gd_addresses WHERE element_id='${widget.id}' AND address_type='1'");

    if(widget.hours!=''){
      setState(() {
        visible=true;
      });

      body = jsonDecode(widget.hours);
      sunS = body['su']['start'];
      monS = body['m']['start'];
      tueS = body['tu']['start'];
      wedS = body['w']['start'];
      thuS = body['th']['start'];
      friS = body['f']['start'];
      satS = body['sa']['start'];

      sunE = body['su']['end'];
      monE = body['m']['end'];
      tueE = body['tu']['end'];
      wedE = body['w']['end'];
      thuE = body['th']['end'];
      friE = body['f']['end'];
      satE = body['sa']['end'];
    }
    else{
      setState(() {
        visible=false;
      });
      sunS = '0:0';
      tueS = '0:0';
      wedS = '0:0';
      monS = '0:0';
      thuS = '0:0';
      friS = '0:0';
      satS = '0:0';

      sunE = '0:0';
      monE = '0:0';
      tueE = '0:0';
      wedE = '0:0';
      thuE = '0:0';
      friE = '0:0';
      satE = '0:0';

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Container(
          width: double.infinity,
          height: 30,
          color: Theme.of(context).primaryColor,
          child: Align(
              alignment: Alignment.topRight,
              child: Label(text: 'Welcome ${widget.uname}',color: Colors.white,)),
        ),
      ),

      body: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15,0,0,15),
              child: Row(
                children: <Widget>[
                  Container(width:35,height:35,child: Image.asset('images/home.png')),
                  SizedBox(width: 10,),
                  Label(color: Colors.white,text: 'Accounts',size: 25,)
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30,80,20,20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Label(text: 'Golden Goose',color: Color(0xffff6600),size: 24,),
                  Label(text: 'McDonalds',color: Color(0xffff6600),size: 24,),
                  SizedBox(height: 10,),
                  Label(text: line1!=null?line1:'Loading',color: Colors.grey,size: 17,),
                  line2!=null?Label(text: line2!=null?line2:'Loading',color: Colors.grey,size: 17,):SizedBox(height: 0,),
                  Label(text: city!=null&&zip!=null?'$city , $zip':'Loading',color: Colors.grey,size: 17,align: TextAlign.start,),

                 SizedBox(height: 30,),
                 Visibility(
                   maintainAnimation: true,
                   maintainState: true,
                   visible: visible,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: <Widget>[
                       Align(
                         alignment: Alignment.centerLeft,
                         child: Padding(
                           padding: const EdgeInsets.symmetric(vertical: 20),
                           child: Label(text: 'Hours',color: Colors.grey,size: 20,),
                         ),
                       ),

                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           Label(text: 'Sunday  ',color: Colors.grey,),
                           SizedBox(width: 20,),
                           Padding(
                             padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/3),
                             child: Label(text: '$sunS h - $sunE h',color: Colors.grey,),
                           ),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           Label(text: 'Monday  ',color: Colors.grey,),
                           SizedBox(width: 20,),
                           Padding(
                             padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/3),
                             child: Label(text: '$monS h - $monE h',color: Colors.grey,),
                           ),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           Label(text: 'Tuesday  ',color: Colors.grey,),
                           SizedBox(width: 20,),
                           Padding(
                             padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/3),
                             child: Label(text: '$tueS h - $tueE h',color: Colors.grey,),
                           ),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           Label(text: 'Wednesday  ',color: Colors.grey,),
                           SizedBox(width: 20,),
                           Padding(
                             padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/3),
                             child: Label(text: '$wedS h - $wedE h',color: Colors.grey,),
                           ),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           Label(text: 'Thursday  ',color: Colors.grey,),
                           SizedBox(width: 20,),
                           Padding(
                             padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/3),
                             child: Label(text: '$thuS h - $thuE h',color: Colors.grey,),
                           ),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           Label(text: 'Friday  ',color: Colors.grey,),
                           SizedBox(width: 20,),
                           Padding(
                             padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/3),
                             child: Label(text: '$friS h - $friE h',color: Colors.grey,),
                           ),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           Label(text: 'Saturday  ',color: Colors.grey,),
                           SizedBox(width: 20,),
                           Padding(
                             padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/3),
                             child: Label(text: '$satS h - $satE h',color: Colors.grey,),
                           ),
                         ],
                       ),
                     ],
                   ),
                 )
                ],
              ),
            ),
          ),


        ],
      ),

    );
  }

}
