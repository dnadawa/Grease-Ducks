import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grease_ducks/widgets/big-image.dart';
import 'package:grease_ducks/widgets/text.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart'
    show ConnectionSettings, MySqlConnection, Results;
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  final String hours;
  final String comName;
  final String uname;
  final String id;
  final String legalName;
  final String suffix;
  final String website;
  final String type;
  final String region;
  final String industry;
  final String status;
  final String paymentType;
  final String paymentTerms;
  final String accountManager;
  final String image;
  final String email;




Details({Key key, this.hours, this.comName='', this.uname='', this.id='', this.legalName='N/A', this.suffix='', this.website='', this.type='', this.region='N/A', this.industry='', this.status='N/A', this.paymentType='',  this.paymentTerms='', this.accountManager='N/A', this.image='', this.email})
      : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool suffixShow=false,webShow=false,phoneShow=false,typeShow=false,industryShow=false,paymentShow=false,paymentTermsshow=false;
  var line1, line2, city, zip,country,_accountManager,_region,_phone='';
  Results results;
  getData(BuildContext context, String query) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'greaseducks.com',
        port: 3306,
        user: 'grease_gdt',
        password: 'Yq4aOB9;NANh',
        db: 'grease_gd'));

    results = await conn.query(query);
    for (var row in results) {
      if (row['name'] == 'line_1') {
        line1 = row['value'];
      }
      if (row['name'] == 'line_2') {
        line2 = row['value'];
      }
      if (row['name'] == 'city') {
        city = row['value'];
      }
      if (row['name'] == 'zip') {
        zip = row['value'];
      }
      if (row['name'] == 'country') {
        country = row['value'];
      }
    }

    setState(() {});

    //print('line 1:$line1 \n line 2:$line2 \n city:$city \n zip:$zip');

    //await conn.close();
  }

  getAccountManager(BuildContext context, String query) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'greaseducks.com',
        port: 3306,
        user: 'grease_gdt',
        password: 'Yq4aOB9;NANh',
        db: 'grease_gd'));

    results = await conn.query(query);
    var row = results.elementAt(0);
    _accountManager = row['firstname']+' '+row['lastname'];
    setState(() {});
  }

  getRegion(BuildContext context, String query) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'greaseducks.com',
        port: 3306,
        user: 'grease_gdt',
        password: 'Yq4aOB9;NANh',
        db: 'grease_gd'));

    results = await conn.query(query);
    var row = results.elementAt(0);
    _region = row['name'];
    setState(() {});
  }

  getPhone(BuildContext context, String query) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'greaseducks.com',
        port: 3306,
        user: 'grease_gdt',
        password: 'Yq4aOB9;NANh',
        db: 'grease_gd'));

    results = await conn.query(query);
    var row = results.elementAt(0);
    _phone = row['value'].replaceAll('/','');
    if(_phone!=''){
      phoneShow=true;
    }
    setState(() {});
  }


  sendMessage(String number) async {
    // Android

    if (Platform.isAndroid) {
      var uri = 'sms:+$number?body=';
      if (await canLaunch(uri)) {
        await launch(uri);
      }
      else{
        throw 'error';
      }
    }else if (Platform.isIOS) {
      var uri = 'sms:$number';
      if (await canLaunch(uri)) {
        await launch(uri);
      }
      else{
        throw 'error';
      }
    }

  }


  sendMail(String mail) async {
    var url = 'mailto:$mail?subject=&body=';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  openMap() async {
    String add = addressCheck();
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$add';


    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  String addressCheck(){
    var line_1 = line1.split(' ');
    var x = '';
    var y = '';
    line_1.forEach((item){
      x = x+'+'+item;
    });

    var zips = zip.split(' ');
    zips.forEach((item){
      y = y+'+'+item;
    });

    String mapString = x+'+'+city+y+'+'+country+'+';
return mapString;

  }

  var sunS,
      sunE,
      monS,
      monE,
      tueS,
      tueE,
      wedS,
      wedE,
      thuS,
      thuE,
      friS,
      friE,
      satS,
      satE;
  var body;
  bool visible;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visible = true;
    getData(context,
        "SELECT name,value FROM gd_addresses WHERE element_id='${widget.id}' AND address_type='1'");
    getAccountManager(context, "SELECT * FROM gd_contacts WHERE id='${widget.accountManager}'");
    getRegion(context, "SELECT * FROM gd_regions WHERE id='${widget.region}'");
    getPhone(context, "SELECT * FROM gd_dynamic_fields WHERE element_id='${widget.id}' AND type='account' AND `key`='Business'");

    if (widget.hours != '') {
      setState(() {
        visible = true;
      });

      body = jsonDecode(widget.hours);
      sunS = body['su']['start'];
      //String fmt = DateFormat("HH:mm").format(sunS);
      //print(fmt);
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
    } else {
      setState(() {
        visible = false;
      });
      sunS = '00:00';
      tueS = '00:00';
      wedS = '00:00';
      monS = '00:00';
      thuS = '00:00';
      friS = '00:00';
      satS = '00:00';

      sunE = '00:00';
      monE = '00:00';
      tueE = '00:00';
      wedE = '00:00';
      thuE = '00:00';
      friE = '00:00';
      satE = '00:00';
    }




    if(widget.suffix!='()'){
      suffixShow=true;
    }
    if(widget.website!=''){
      webShow=true;
    }

    if(widget.type!=''){
      typeShow=true;
    }
    if(widget.industry!=''){
      industryShow=true;
    }
    if(widget.paymentType!=''){
      paymentShow=true;
    }

    if(widget.paymentTerms!=''){
      paymentTermsshow=true;
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
              child: Label(
                text: 'Welcome ${widget.uname}',
                color: Colors.white,
              )),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                      width: 35,
                      height: 35,
                      child: Image.asset('images/home.png')),
                  SizedBox(
                    width: 10,
                  ),
                  Label(
                    color: Colors.white,
                    text: 'Accounts',
                    size: 25,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 10, 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 30),

                    Row(
                      children: <Widget>[
                        widget.image!=''?GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => BigImage(url: 'http://www.greaseducks.com/accounts/uploads/${widget.image}',)),
                            );
                          },
                          child: Container(
                            height: 80,
                            child: Image.network('http://www.greaseducks.com/accounts/uploads/${widget.image}'),
                            color: Colors.teal,
                          ),
                        ):null,
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: widget.image!=''?205:double.infinity,
                              child: Label(
                                text: widget.legalName,
                                color: Color(0xffff6600),
                                size: 20,
                                bold: false,
                              ),
                            ),
                            Label(
                              text: widget.comName,
                              color: Color(0xffff6600),
                              size: 22,
                            ),
                            Visibility(
                              visible: suffixShow,
                              child: Label(
                                text: widget.suffix,
                                color: Colors.grey,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: ()=>phoneShow?sendMessage(_phone):null,
                            child: CircleAvatar(
                              backgroundColor: phoneShow?Colors.blue:Colors.grey,
                              radius: 30,
                              child: Icon(Icons.message,color: Colors.white,),
                            ),
                          ),
                          SizedBox(width: 20,),
                          GestureDetector(
                            onTap: (){phoneShow?launch("tel://$_phone"):null;},
                            child: CircleAvatar(
                              backgroundColor: phoneShow?Colors.blue:Colors.grey,
                              radius: 30,
                              child: Icon(
                                Icons.call,
                                color: Colors.white,
                              ),
                            ),
                          ),
//                          CircleAvatar(
//                            backgroundColor: Colors.blue,
//                            radius: 30,
//                            child: Icon(
//                              Icons.videocam,
//                              color: Colors.white,
//                            ),
//                          ),
                          SizedBox(width: 20,),
                          GestureDetector(
                            onTap: ()=>widget.email!=''?sendMail(widget.email):null,
                            child: CircleAvatar(
                              backgroundColor: widget.email!=''?Colors.blue:Colors.grey,
                              radius: 30,
                              child: Icon(
                                Icons.mail,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Divider(
                      thickness: 1,
                    ),

                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Label(
                              text: 'Main Address',
                              color: Colors.black,
                              size: 24,
                            ),
                            Label(
                              text: line1!=null?line1:'Loading',
                              color: Colors.grey,
                              size: 17,
                            ),
                            Label(
                              text: city!=null&&zip!=null?'$city ,$zip':'Loading',
                              color: Colors.grey,
                              size: 17,
                            ),
                            Label(
                              text: country!=null?country:'Loading',
                              color: Colors.grey,
                              size: 17,
                            ),
                          ],
                        ),

                        GestureDetector(
                          onTap: ()=>openMap(),
                          child: Container(
                            width: 70,
                            height:70,
                            child: Image.asset('images/map.png'),

                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),

                    Divider(
                      thickness: 1,
                    ),

                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Label(
                          text: 'Contact Info',
                          color: Colors.black,
                          size: 24,
                        ),
                        Visibility(
                            visible: phoneShow,
                            child: SizedBox(height: 8)),
                        Visibility(
                          visible: phoneShow,
                          child: Label(
                            text: 'Business',
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                        Visibility(
                          visible: phoneShow,
                          child: Label(
                            text: _phone!=null?_phone:'N/A',
                            color: Colors.grey,
                            size: 17,
                            bold: false,
                          ),
                        ),

                        Visibility(
                            visible: webShow,
                            child: SizedBox(height: 15)),
                        Visibility(
                          visible: webShow,
                          child: Label(
                            text: 'Website',
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                        Visibility(
                          visible: webShow,
                          child: Label(
                            text: widget.website,
                            color: Colors.grey,
                            size: 17,
                            bold: false,
                          ),
                        ),

                        SizedBox(height: 15),
                        Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          visible: true,
                          child: Label(
                            text: 'Hours',
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                        SizedBox(height: 15),
                        Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          visible: visible,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Label(
                                    text: 'Sunday  ',
                                    color: Colors.grey,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: MediaQuery.of(context).size.width / 3),
                                    child: Label(
                                      text: '$sunS h - $sunE h',
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Label(
                                    text: 'Monday  ',
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: MediaQuery.of(context).size.width / 3),
                                    child: Label(
                                      text: '$monS h - $monE h',
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Label(
                                    text: 'Tuesday  ',
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: MediaQuery.of(context).size.width / 3),
                                    child: Label(
                                      text: '$tueS h - $tueE h',
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Label(
                                    text: 'Wednesday  ',
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: MediaQuery.of(context).size.width / 3),
                                    child: Label(
                                      text: '$wedS h - $wedE h',
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Label(
                                    text: 'Thursday  ',
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: MediaQuery.of(context).size.width / 3),
                                    child: Label(
                                      text: '$thuS h - $thuE h',
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Label(
                                    text: 'Friday  ',
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: MediaQuery.of(context).size.width / 3),
                                    child: Label(
                                      text: '$friS h - $friE h',
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Label(
                                    text: 'Saturday  ',
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: MediaQuery.of(context).size.width / 3),
                                    child: Label(
                                      text: '$satS h - $satE h',
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    Divider(
                      thickness: 1,
                    ),

                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Label(
                          text: 'Additional Info',
                          color: Colors.black,
                          size: 24,
                        ),
                        Visibility(
                            visible: typeShow,
                            child: SizedBox(height: 8)),
                       Visibility(
                         visible: typeShow,
                         child: Row(
                           children: <Widget>[
                             Label(
                               text: 'Type',
                               color: Colors.grey,
                               size: 19,
                             ),
                             SizedBox(width: 10),
                             Label(
                               text: widget.type,
                               color: Colors.grey,
                               size: 19,
                               bold: false,
                             ),
                           ],
                         ),
                       ),

                        SizedBox(height: 8),
                        Row(
                          children: <Widget>[
                            Label(
                              text: 'Region',
                              color: Colors.grey,
                              size: 19,
                            ),
                            SizedBox(width: 10),
                            Label(
                              text: _region??'N/A',
                              color: Colors.grey,
                              size: 19,
                              bold: false,
                            ),
                          ],
                        ),

                        Visibility(
                            visible: industryShow,
                            child: SizedBox(height: 8)),
                        Visibility(
                          visible: industryShow,
                          child: Row(
                            children: <Widget>[
                              Label(
                                text: 'Industry',
                                color: Colors.grey,
                                size: 19,
                              ),
                              SizedBox(width: 10),
                              Label(
                                text: widget.industry,
                                color: Colors.grey,
                                size: 19,
                                bold: false,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 8),
                        Row(
                          children: <Widget>[
                            Label(
                              text: 'Status',
                              color: Colors.grey,
                              size: 19,
                            ),
                            SizedBox(width: 10),
                            Label(
                              text: widget.status,
                              color: Colors.green,
                              size: 19,
                              bold: false,
                            ),
                          ],
                        ),

                        Visibility(
                            visible: paymentShow,
                            child: SizedBox(height: 8)),
                        Visibility(
                          visible: paymentShow,
                          child: Row(
                            children: <Widget>[
                              Label(
                                text: 'Preferred Payment Type',
                                color: Colors.grey,
                                size: 19,
                              ),
                              SizedBox(width: 10),
                              Label(
                                text: widget.paymentType??'N/A',
                                color: Colors.grey,
                                size: 19,
                                bold: false,
                              ),
                            ],
                          ),
                        ),

                        Visibility(
                            visible: paymentTermsshow,
                            child: SizedBox(height: 8)),
                        Visibility(
                          visible: paymentTermsshow,
                          child: Row(
                            children: <Widget>[
                              Label(
                                text: 'Payment Terms',
                                color: Colors.grey,
                                size: 19,
                              ),
                              SizedBox(width: 10),
                              Label(
                                text: widget.paymentTerms,
                                color: Colors.grey,
                                size: 19,
                                bold: false,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 8),
                        Row(
                          children: <Widget>[
                            Label(
                              text: 'Account Manager',
                              color: Colors.grey,
                              size: 19,
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              width: 160,
                              child: Label(
                                text: _accountManager??'N/A',
                                color: Colors.grey,
                                size: 19,
                                bold: false,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),


                  ],
                ),
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black54,width: 0.3),
                ),
                color: Colors.grey.shade200,
    ),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: IconTheme.merge( // Default with the inactive state.
                data: IconThemeData(color: Colors.green, size: 35),
                child: DefaultTextStyle( // Default with the inactive state.
                  style: CupertinoTheme.of(context).textTheme.tabLabelTextStyle.copyWith(color: Colors.green),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 30,
                            height: 30,
                            child: Image.asset('images/contacts.png')),
                        Container(
                            width: 30,
                            height: 30,
                            child: Image.asset('images/cal.png'))
                      ],
                    ),
                  ),
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }
}
