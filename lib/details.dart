import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grease_ducks/widgets/text.dart';
import 'package:mysql1/mysql1.dart'
    show ConnectionSettings, MySqlConnection, Results;

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



  const Details({Key key, this.hours, this.comName='', this.uname='', this.id='', this.legalName='N/A', this.suffix='N/A', this.website='N/A', this.type='N/A', this.region='N/A', this.industry='N/A', this.status='N/A', this.paymentType='N/A', this.paymentTerms='N/A', this.accountManager='N/A', this.image=''})
      : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var line1, line2, city, zip,country;
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

    if (widget.hours != '') {
      setState(() {
        visible = true;
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
    } else {
      setState(() {
        visible = false;
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
                        widget.image!=''?Container(
                          height: 80,
                          child: Image.network('http://www.greaseducks.com/accounts/uploads/${widget.image}'),
                          color: Colors.teal,
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
                            Label(
                              text: widget.suffix,
                              color: Colors.grey,
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 30,
                            child: Icon(Icons.message,color: Colors.white,),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 30,
                            child: Icon(
                              Icons.call,
                              color: Colors.white,
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 30,
                            child: Icon(
                              Icons.videocam,
                              color: Colors.white,
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 30,
                            child: Icon(
                              Icons.mail,
                              color: Colors.white,
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

                        Container(
                          width: 70,
                          height:70,
                          color: Colors.red,
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
                        SizedBox(height: 8),
                        Label(
                          text: 'Business',
                          color: Colors.grey,
                          size: 20,
                        ),
                        Label(
                          text: 'number',
                          color: Colors.grey,
                          size: 17,
                          bold: false,
                        ),

                        SizedBox(height: 15),
                        Label(
                          text: 'Website',
                          color: Colors.grey,
                          size: 20,
                        ),
                        Label(
                          text: widget.website,
                          color: Colors.grey,
                          size: 17,
                          bold: false,
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
                          visible: true,
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
                        SizedBox(height: 8),
                       Row(
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
                              text: 'region',
                              color: Colors.grey,
                              size: 19,
                              bold: false,
                            ),
                          ],
                        ),

                        SizedBox(height: 8),
                        Row(
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
                              text: widget.industry,
                              color: Colors.green,
                              size: 19,
                              bold: false,
                            ),
                          ],
                        ),

                        SizedBox(height: 8),
                        Row(
                          children: <Widget>[
                            Label(
                              text: 'Prefferd Payment Type',
                              color: Colors.grey,
                              size: 19,
                            ),
                            SizedBox(width: 10),
                            Label(
                              text: widget.paymentType,
                              color: Colors.grey,
                              size: 19,
                              bold: false,
                            ),
                          ],
                        ),

                        SizedBox(height: 8),
                        Row(
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
                                text: 'account_manager',
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
        ],
      ),
    );
  }
}
