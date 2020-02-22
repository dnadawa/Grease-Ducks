import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grease_ducks/details.dart';
import 'package:grease_ducks/recently_view.dart';
import 'package:grease_ducks/widgets/text.dart';
import 'package:grease_ducks/widgets/textbox.dart';
import 'package:mysql1/mysql1.dart' show ConnectionSettings, MySqlConnection, Results;
import 'package:shared_preferences/shared_preferences.dart';

class Accounts extends StatefulWidget {
  final String uname;

  const Accounts({Key key, this.uname}) : super(key: key);

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  String status,type,region,industry,city,sortby,sortOrder;
Results results,recentlyViewed;
TextEditingController search = TextEditingController();


getData(BuildContext context,String query) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'greaseducks.com',
        port: 3306,
        user: 'grease_gdt',
        password: 'Yq4aOB9;NANh',
        db: 'grease_gd'));

    // Query the database using a parameterized query

    results = await conn.query(query);
    setState(() {});

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
    getData(context,"SELECT * FROM gd_accounts ORDER BY company_name");
    status = 'All';
    type = 'All';
    region = 'All';
    industry = 'All';
    city = 'All';
    sortby = 'company_name';
    sortOrder = 'Ascending';
    super.initState();
  }



_displayDialog(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
            return AlertDialog(
              title: Text('Filter'),
              content: Column(
                children: <Widget>[
                  Label(text: 'Status',size: 18,),
                  DropdownButton(
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(child: Label(text: 'All',),value: 'All',),
                      DropdownMenuItem(child: Label(text: 'Active',),value: 'Active',),
                      DropdownMenuItem(child: Label(text: 'Closed',),value: 'Closed',),
                      DropdownMenuItem(child: Label(text: 'Inactive',),value: 'Inactive',),
                    ],onChanged:(newValue){
                    setState(() {
                      status = newValue;
                    });
                    },
                    value: status,
                  ),

                  SizedBox(height: 10,),
                  Label(text: 'Type',size: 18,),
                  DropdownButton(
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(child: Label(text: 'All',),value: 'All',),
                      DropdownMenuItem(child: Label(text: 'Client',),value: 'Client',),
                      DropdownMenuItem(child: Label(text: 'Contractor',),value: 'Contractor',),
                      DropdownMenuItem(child: Label(text: 'Education',),value: 'Education',),
                      DropdownMenuItem(child: Label(text: 'Lead',),value: 'Lead',),
                      DropdownMenuItem(child: Label(text: 'Legal',),value: 'Legal',),
                      DropdownMenuItem(child: Label(text: 'Management',),value: 'Management',),
                      DropdownMenuItem(child: Label(text: 'Marketing',),value: 'Marketing',),
                      DropdownMenuItem(child: Label(text: 'Partner',),value: 'Partner',),
                      DropdownMenuItem(child: Label(text: 'Sales',),value: 'Sales',),
                      DropdownMenuItem(child: Label(text: 'Sales Representative',),value: 'Sales Representative',),
                      DropdownMenuItem(child: Label(text: 'Services',),value: 'Services',),
                      DropdownMenuItem(child: Label(text: 'Supplier',),value: 'Supplier',),
                      DropdownMenuItem(child: Label(text: 'Staff',),value: 'Staff',),
                      DropdownMenuItem(child: Label(text: 'Account Representative',),value: 'Account Representative',),

                    ],onChanged:(newValue){
                    setState(() {
                      type = newValue;
                    });
                  },
                    value: type,
                  ),

                  SizedBox(height: 10,),
                  Label(text: 'Region',size: 18,),
                  DropdownButton(
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(child: Label(text: 'All',),value: 'All',),
                      DropdownMenuItem(child: Label(text: 'Head Office',),value: '4',),
                      DropdownMenuItem(child: Label(text: 'GVRD',),value: '2',),
                      DropdownMenuItem(child: Label(text: 'FVRD',),value: '1',),
                      DropdownMenuItem(child: Label(text: 'GVR',),value: '12',),
                      DropdownMenuItem(child: Label(text: 'RMOW',),value: '3',),
                      DropdownMenuItem(child: Label(text: 'CRD',),value: '7',),
                      DropdownMenuItem(child: Label(text: 'SCRD',),value: '9',),
                      DropdownMenuItem(child: Label(text: 'SLRD',),value: '10',),
                      DropdownMenuItem(child: Label(text: 'RDOS',),value: '11',),
                      DropdownMenuItem(child: Label(text: 'GTA',),value: '5',),
                      DropdownMenuItem(child: Label(text: 'SF',),value: '8',),


                    ],onChanged:(newValue){
                    setState(() {
                      region = newValue;
                    });
                  },
                    value: region,
                  ),

                  SizedBox(height: 10,),
                  Label(text: 'Industry',size: 18,),
                  DropdownButton(
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(child: Label(text: 'All',),value: 'All',),
                      DropdownMenuItem(child: Label(text: 'Automotive',),value: 'Automotive',),
                      DropdownMenuItem(child: Label(text: 'Casino',),value: 'Casino',),
                      DropdownMenuItem(child: Label(text: 'Caterer',),value: 'Caterer',),
                      DropdownMenuItem(child: Label(text: 'Catering',),value: 'Catering',),
                      DropdownMenuItem(child: Label(text: 'Catering Truck',),value: 'Catering Truck',),
                      DropdownMenuItem(child: Label(text: 'Church',),value: 'Church',),
                      DropdownMenuItem(child: Label(text: 'Club',),value: 'Club',),
                      DropdownMenuItem(child: Label(text: 'Concession Stand',),value: 'Concession Stand',),
                      DropdownMenuItem(child: Label(text: 'Education',),value: 'Education',),
                      DropdownMenuItem(child: Label(text: 'Financial',),value: 'Financial',),
                      DropdownMenuItem(child: Label(text: 'Food Processing',),value: 'Food Processing',),
                      DropdownMenuItem(child: Label(text: 'Government',),value: 'Government',),
                      DropdownMenuItem(child: Label(text: 'Hotel',),value: 'Hotel',),
                      DropdownMenuItem(child: Label(text: 'Housing',),value: 'Housing',),
                      DropdownMenuItem(child: Label(text: 'Housing / Residency',),value: 'Housing / Residency',),
                      DropdownMenuItem(child: Label(text: 'Legal',),value: 'Legal',),
                      DropdownMenuItem(child: Label(text: 'Ltd Service Food Establis',),value: 'Ltd Service Food Establis',),
                      DropdownMenuItem(child: Label(text: 'Manufacturer - Food',),value: 'Manufacturer - Food',),
                      DropdownMenuItem(child: Label(text: 'Manufacturer - Food with',),value: 'Manufacturer - Food with',),
                      DropdownMenuItem(child: Label(text: 'Professional Services',),value: 'Professional Services',),
                      DropdownMenuItem(child: Label(text: 'Property Management',),value: 'Property Management',),
                      DropdownMenuItem(child: Label(text: 'Restarant',),value: 'Restarant',),
                      DropdownMenuItem(child: Label(text: 'Restaurant Class 1',),value: 'Restaurant Class 1',),
                      DropdownMenuItem(child: Label(text: 'Restaurant Class 2',),value: 'Restaurant Class 2',),
                      DropdownMenuItem(child: Label(text: 'Retail',),value: 'Retail',),
                      DropdownMenuItem(child: Label(text: 'Trade Shows / Conventions',),value: 'Trade Shows / Conventions',),
                      DropdownMenuItem(child: Label(text: 'Wholesale',),value: 'Wholesale',),
                    ],onChanged:(newValue){
                    setState(() {
                      industry = newValue;
                    });
                  },
                    value: industry,
                  ),

                  SizedBox(height: 10,),
                  Label(text: 'City',size: 18,),
                  DropdownButton(
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(child: Label(text: 'All',),value: 'All',),
                      DropdownMenuItem(child: Label(text: 'Abbotsford',),value: 'Abbotsford',),
                      DropdownMenuItem(child: Label(text: 'Agassiz',),value: 'Agassiz',),
                      DropdownMenuItem(child: Label(text: 'Alcester',),value: 'Alcester',),
                      DropdownMenuItem(child: Label(text: 'Aldergrove',),value: 'Aldergrove',),
                      DropdownMenuItem(child: Label(text: 'Anmore',),value: 'Anmore',),
                      DropdownMenuItem(child: Label(text: 'Ashland',),value: 'Ashland',),
                      DropdownMenuItem(child: Label(text: 'Aurora',),value: 'Aurora',),
                      DropdownMenuItem(child: Label(text: 'Austin',),value: 'Austin',),
                      DropdownMenuItem(child: Label(text: 'Bedford',),value: 'Bedford',),
                      DropdownMenuItem(child: Label(text: 'Belmont',),value: 'Belmont',),
                      DropdownMenuItem(child: Label(text: 'Blauvelt',),value: 'Blauvelt',),
                      DropdownMenuItem(child: Label(text: 'Bluefield',),value: 'Bluefield',),
                      DropdownMenuItem(child: Label(text: 'Bowen Island',),value: 'Bowen Island',),
                      DropdownMenuItem(child: Label(text: 'Brampton',),value: 'Brampton',),
                      DropdownMenuItem(child: Label(text: 'Brooklyn',),value: 'Brooklyn',),
                      DropdownMenuItem(child: Label(text: 'Burlington',),value: 'Burlington',),
                      DropdownMenuItem(child: Label(text: 'Burnaby',),value: 'Burnaby',),
                      DropdownMenuItem(child: Label(text: 'Calgary',),value: 'Calgary',),
                      DropdownMenuItem(child: Label(text: 'California',),value: 'California',),
                      DropdownMenuItem(child: Label(text: 'Chetwynd',),value: 'Chetwynd',),
                      DropdownMenuItem(child: Label(text: 'Chilliwack',),value: 'Chilliwack',),
                      DropdownMenuItem(child: Label(text: 'City',),value: 'City',),
                      DropdownMenuItem(child: Label(text: 'Comox',),value: 'Comox',),
                      DropdownMenuItem(child: Label(text: 'Concord',),value: 'Concord',),
                      DropdownMenuItem(child: Label(text: 'Coquitlam',),value: 'Coquitlam',),
                      DropdownMenuItem(child: Label(text: 'Courtenay',),value: 'Courtenay',),
                      DropdownMenuItem(child: Label(text: 'Cranbrook',),value: 'Cranbrook',),
                      DropdownMenuItem(child: Label(text: 'Deland',),value: 'Deland',),
                      DropdownMenuItem(child: Label(text: 'Delta',),value: 'Delta',),
                      DropdownMenuItem(child: Label(text: 'Eden Prairie',),value: 'Eden Prairie',),
                      DropdownMenuItem(child: Label(text: 'Edmonton',),value: 'Edmonton',),
                      DropdownMenuItem(child: Label(text: 'Egmont',),value: 'Egmont',),
                      DropdownMenuItem(child: Label(text: 'Elfers',),value: 'Elfers',),
                      DropdownMenuItem(child: Label(text: 'Elgin',),value: 'Elgin',),
                      DropdownMenuItem(child: Label(text: 'Elizabeth',),value: 'Elizabeth',),
                      DropdownMenuItem(child: Label(text: 'Elk Point',),value: 'Elk Point',),
                      DropdownMenuItem(child: Label(text: 'Elmira',),value: 'Elmira',),
                      DropdownMenuItem(child: Label(text: 'Export',),value: 'Export',),
                      DropdownMenuItem(child: Label(text: 'Ferndale',),value: 'Ferndale',),
                      DropdownMenuItem(child: Label(text: 'Freetown',),value: 'Freetown',),
                      DropdownMenuItem(child: Label(text: 'Furry Creek',),value: 'Furry Creek',),
                      DropdownMenuItem(child: Label(text: 'Galiano Island',),value: 'Galiano Island',),
                      DropdownMenuItem(child: Label(text: 'Garibaldi Highlands',),value: 'Garibaldi Highlands',),
                      DropdownMenuItem(child: Label(text: 'Garland',),value: 'Garland',),
                      DropdownMenuItem(child: Label(text: 'Gibsons',),value: 'Gibsons',),
                      DropdownMenuItem(child: Label(text: 'Greer',),value: 'Greer',),
                      DropdownMenuItem(child: Label(text: 'Gulfport',),value: 'Gulfport',),
                      DropdownMenuItem(child: Label(text: 'Gunzenhausen',),value: 'Gunzenhausen',),
                      DropdownMenuItem(child: Label(text: 'Hagatna',),value: 'Hagatna',),
                      DropdownMenuItem(child: Label(text: 'Haida Gwaii',),value: 'Haida Gwaii',),
                      DropdownMenuItem(child: Label(text: 'Halfmoon Bay',),value: 'Halfmoon Bay',),
                      DropdownMenuItem(child: Label(text: 'Harrison Hot Springs',),value: 'Harrison Hot Springs',),
                      DropdownMenuItem(child: Label(text: 'Hope',),value: 'Hope',),
                      DropdownMenuItem(child: Label(text: 'Kamloops',),value: 'Kamloops',),
                      DropdownMenuItem(child: Label(text: 'Kelowna',),value: 'Kelowna',),
                      DropdownMenuItem(child: Label(text: 'Kennewick',),value: 'Kennewick',),
                      DropdownMenuItem(child: Label(text: 'Langley',),value: 'Langley',),
                      DropdownMenuItem(child: Label(text: 'Langley City',),value: 'Langley City',),
                      DropdownMenuItem(child: Label(text: 'Las Vegas',),value: 'Las Vegas',),
                      DropdownMenuItem(child: Label(text: 'Le Mans',),value: 'Le Mans',),
                      DropdownMenuItem(child: Label(text: 'Lebanon',),value: 'Lebanon',),
                      DropdownMenuItem(child: Label(text: 'Lions Bay',),value: 'Lions Bay',),
                      DropdownMenuItem(child: Label(text: 'London',),value: 'London',),
                      DropdownMenuItem(child: Label(text: 'Lynn',),value: 'Lynn',),
                      DropdownMenuItem(child: Label(text: 'Madeira Park',),value: 'Madeira Park',),
                      DropdownMenuItem(child: Label(text: 'Maple Ridge',),value: 'Maple Ridge',),
                      DropdownMenuItem(child: Label(text: 'Masett',),value: 'Masett',),
                      DropdownMenuItem(child: Label(text: 'Matsqui',),value: 'Matsqui',),
                      DropdownMenuItem(child: Label(text: 'Mesa',),value: 'Mesa',),
                      DropdownMenuItem(child: Label(text: 'Mission',),value: 'Mission',),
                      DropdownMenuItem(child: Label(text: 'Mississauga',),value: 'Mississauga',),
                      DropdownMenuItem(child: Label(text: 'Moncton',),value: 'Moncton',),
                      DropdownMenuItem(child: Label(text: 'Montegomery',),value: 'Montegomery',),
                      DropdownMenuItem(child: Label(text: 'Moscow',),value: 'Moscow',),
                      DropdownMenuItem(child: Label(text: 'Nampa',),value: 'Nampa',),
                      DropdownMenuItem(child: Label(text: 'Nanaimo',),value: 'Nanaimo',),
                      DropdownMenuItem(child: Label(text: 'New Haven',),value: 'New Haven',),
                      DropdownMenuItem(child: Label(text: 'New Westminister',),value: 'New Westminister',),
                      DropdownMenuItem(child: Label(text: 'New Westminster',),value: 'New Westminster',),
                      DropdownMenuItem(child: Label(text: 'New York',),value: 'New York',),
                      DropdownMenuItem(child: Label(text: 'Newburgh',),value: 'Newburgh',),
                      DropdownMenuItem(child: Label(text: 'Newport News',),value: 'Newport News',),
                      DropdownMenuItem(child: Label(text: 'North Delta',),value: 'North Delta',),
                      DropdownMenuItem(child: Label(text: 'North Kansas City',),value: 'North Kansas City',),
                      DropdownMenuItem(child: Label(text: 'North Little Rock',),value: 'North Little Rock',),
                      DropdownMenuItem(child: Label(text: 'North Vancouver',),value: 'North Vancouver',),
                      DropdownMenuItem(child: Label(text: 'North Vancover',),value: 'North Vancover',),
                      DropdownMenuItem(child: Label(text: 'Oakville',),value: 'Oakville',),
                      DropdownMenuItem(child: Label(text: 'Oklahoma City',),value: 'Oklahoma City',),
                      DropdownMenuItem(child: Label(text: 'Orange',),value: 'Orange',),
                      DropdownMenuItem(child: Label(text: 'Ottawa',),value: 'Ottawa',),
                      DropdownMenuItem(child: Label(text: 'Pemberton ',),value: 'Pemberton ',),
                      DropdownMenuItem(child: Label(text: 'Penticton',),value: 'Penticton',),
                      DropdownMenuItem(child: Label(text: 'Phoenixville',),value: 'Phoenixville',),
                      DropdownMenuItem(child: Label(text: 'Pitt Meadows',),value: 'Pitt Meadows',),
                      DropdownMenuItem(child: Label(text: 'Port Coquitlam',),value: 'Port Coquitlam',),
                      DropdownMenuItem(child: Label(text: 'Port Mellon',),value: 'Port Mellon',),
                      DropdownMenuItem(child: Label(text: 'Port Moody',),value: 'Port Moody',),
                      DropdownMenuItem(child: Label(text: 'Powell River',),value: 'Powell River',),
                      DropdownMenuItem(child: Label(text: 'Prince George',),value: 'Prince George',),
                      DropdownMenuItem(child: Label(text: 'Qingdao',),value: 'Qingdao',),
                      DropdownMenuItem(child: Label(text: 'Quebec',),value: 'Quebec',),
                      DropdownMenuItem(child: Label(text: 'Queensbury',),value: 'Queensbury',),
                      DropdownMenuItem(child: Label(text: 'Raleigh',),value: 'Raleigh',),
                      DropdownMenuItem(child: Label(text: 'Redmond',),value: 'Redmond',),
                      DropdownMenuItem(child: Label(text: 'Richmond',),value: 'Richmond',),
                      DropdownMenuItem(child: Label(text: 'Roberts Creek',),value: 'Roberts Creek',),
                      DropdownMenuItem(child: Label(text: 'Rock Valley',),value: 'Rock Valley',),
                      DropdownMenuItem(child: Label(text: 'Rocky Point',),value: 'Rocky Point',),
                      DropdownMenuItem(child: Label(text: 'San Diego',),value: 'San Diego',),
                      DropdownMenuItem(child: Label(text: 'San Francisco',),value: 'San Francisco',),
                      DropdownMenuItem(child: Label(text: 'Scarborough',),value: 'Scarborough',),
                      DropdownMenuItem(child: Label(text: 'Seattle',),value: 'Seattle',),
                      DropdownMenuItem(child: Label(text: 'Sechelt',),value: 'Sechelt',),
                      DropdownMenuItem(child: Label(text: 'Shanghai',),value: 'Shanghai',),
                      DropdownMenuItem(child: Label(text: 'Shangyu',),value: 'Shangyu',),
                      DropdownMenuItem(child: Label(text: 'Shawnigan Lake',),value: 'Shawnigan Lake',),
                      DropdownMenuItem(child: Label(text: 'Smithville',),value: 'Smithville',),
                      DropdownMenuItem(child: Label(text: 'Somerset',),value: 'Somerset',),
                      DropdownMenuItem(child: Label(text: 'South Surrey',),value: 'South Surrey',),
                      DropdownMenuItem(child: Label(text: 'Squamish',),value: 'Squamish',),
                      DropdownMenuItem(child: Label(text: 'St ignace',),value: 'St ignace',),
                      DropdownMenuItem(child: Label(text: 'St. Albert',),value: 'St. Albert',),
                      DropdownMenuItem(child: Label(text: 'St. John\'s',),value: 'St. John\'s',),
                      DropdownMenuItem(child: Label(text: 'Surrey',),value: 'Surrey',),
                      DropdownMenuItem(child: Label(text: 'Tel Aviv',),value: 'Tel Aviv',),
                      DropdownMenuItem(child: Label(text: 'Toronto',),value: 'Toronto',),
                      DropdownMenuItem(child: Label(text: 'Tsawwassen',),value: 'Tsawwassen',),
                      DropdownMenuItem(child: Label(text: 'Valemount',),value: 'Valemount',),
                      DropdownMenuItem(child: Label(text: 'Vancouver',),value: 'Vancouver',),
                      DropdownMenuItem(child: Label(text: 'Vaughan',),value: 'Vaughan',),
                      DropdownMenuItem(child: Label(text: 'Vernon',),value: 'Vernon',),
                      DropdownMenuItem(child: Label(text: 'Victoria',),value: 'Victoria',),
                      DropdownMenuItem(child: Label(text: 'Washington',),value: 'Washington',),
                      DropdownMenuItem(child: Label(text: 'West Kelowna',),value: 'West Kelowna',),
                      DropdownMenuItem(child: Label(text: 'West Vancouver',),value: 'West Vancouver',),
                      DropdownMenuItem(child: Label(text: 'Whistler',),value: 'Whistler',),
                      DropdownMenuItem(child: Label(text: 'White Rock',),value: 'White Rock',),
                      DropdownMenuItem(child: Label(text: 'williams lake',),value: 'williams lake',),
                      DropdownMenuItem(child: Label(text: 'Windsor',),value: 'Windsor',),
                      DropdownMenuItem(child: Label(text: 'Woburn',),value: 'Woburn',),
                      ],onChanged:(newValue){
                    setState(() {
                      city = newValue;
                    });
                  },
                    value: city,
                  ),

                  SizedBox(height: 10,),
                  Label(text: 'Sort By',size: 18,),
                  SizedBox(height: 10,),
                  DropdownButton(
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(child: Label(text: 'Company Name',),value: 'company_name',),
                      DropdownMenuItem(child: Label(text: 'Status',),value: 'status',),
                      DropdownMenuItem(child: Label(text: 'Type',),value: 'type',),
                      DropdownMenuItem(child: Label(text: 'Date Added',),value: 'created',),
                      DropdownMenuItem(child: Label(text: 'City',),value: 'city',),
                      DropdownMenuItem(child: Label(text: 'State',),value: 'state',),
                      DropdownMenuItem(child: Label(text: 'Address',),value: 'address',),

                    ],onChanged:(newValue){
                    setState(() {
                      sortby = newValue;
                    });
                  },
                    value: sortby,
                  ),
                  DropdownButton(
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(child: Label(text: 'Ascending',),value: 'Ascending',),
                      DropdownMenuItem(child: Label(text: 'Descending',),value: 'Descending',),
                    ],onChanged:(newValue){
                    setState(() {
                      sortOrder = newValue;
                    });
                  },
                    value: sortOrder,
                  ),
                ],
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('CANCEL',style: TextStyle(color: Theme.of(context).primaryColor),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text('CLEAR',style: TextStyle(color: Theme.of(context).primaryColor),),
                  onPressed: () {
                    setState(() {
                      status = 'All';
                      type = 'All';
                      region = 'All';
                      industry = 'All';
                      city = 'All';
                      sortby = 'company_name';
                      sortOrder = 'Ascending';
                    });
                  },
                ),
                new FlatButton(
                  child: new Text('OK',style: TextStyle(color: Theme.of(context).primaryColor)),
                  onPressed: () async {
                    var statusQuery,typeQuery,regionQuery,industryQuery,cityQuery,order;
                    if(status=='All'){
                      statusQuery='';
                    }
                    else{
                      statusQuery = " AND status='$status'";
                    }

                    if(type=='All'){
                      typeQuery='';
                    }
                    else{
                      typeQuery = " AND type='$type'";
                    }


                    if(industry=='All'){
                      industryQuery='';
                    }
                    else{
                      industryQuery = " AND industry='$industry'";
                    }


                    if(city=='All'){
                      cityQuery='';
                    }
                    else{
                      cityQuery = " AND city='$city'";
                    }

                    if(region=='All'){
                      regionQuery='';
                    }
                    else{
                      regionQuery = " AND region='$region'";
                    }

                    if(sortOrder == 'Ascending'){
                      order = '';
                    }
                    else{
                      order =' DESC';
                    }

                    var mainQuery = "SELECT * FROM gd_accounts,gd_regions WHERE company_name!=''$statusQuery$typeQuery$industryQuery$cityQuery$regionQuery ORDER BY $sortby$order";

                    print('<start>$mainQuery<end>');
                    await getData(context, mainQuery);
                    setState(() {});
                    Navigator.pop(context);


                  },
                )
              ],
            );
          },
        );
      });
}




  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState){

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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


            Container(
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoTextField(
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Icon(Icons.search,color: Colors.grey,),
                        ),
                        style: textStyle,
                        cursorColor: Colors.green,
                        suffix: IconButton(icon: Icon(Icons.clear), onPressed: () async {
                          print('clicked');
                          search.clear();
                          await getData(context, "SELECT * FROM gd_accounts ORDER BY company_name");

                          setState(() {});
                          FocusScope.of(context).requestFocus(FocusNode());

                        }),
                        placeholder: 'Search',
                        padding: EdgeInsets.fromLTRB(10,15,10,15),
                        keyboardType: TextInputType.text,
                        controller: search,
                        onEditingComplete: () async {
                          await getData(context, "SELECT * FROM gd_accounts WHERE company_name LIKE '%${search.text}%'");
                          setState(() {});
                          FocusScope.of(context).requestFocus(FocusNode());
                        },

                      ),
                    ),
                  ),

                  GestureDetector(
                      onTap: ()=>_displayDialog(context),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          width: 60,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Colors.grey.shade200
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('images/filter.png'),
                          ),),
                      ))

                ],
              ),
            ),


            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                                onTap: () async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                var id =   prefs.getString('uid');
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(builder: (context) => RecentlyViewed(uname: widget.uname,uid: id,)),
                                  );
                                },
                                child: Label(text: 'Recently Viewed',size: 18,))),
                      ),
                    ),


                    results!=null?Expanded(
                      child: ListView.builder(
                        physics: ScrollPhysics(),

                        shrinkWrap: true,
                        itemCount: results!=null?results.length:0,

                        itemBuilder: (context,i){

                          var suffix = results.elementAt(i)['suffix'];
                          var finalSuffix = suffix!=''?'($suffix)':'';

                          var name = results.elementAt(i)['company_name']+' $finalSuffix';

                          return Column(
                            children: <Widget>[
                              ListTile(
                                dense: true,
                                title: Label(text: name,),
                                onTap: () async {

                                  String hours = results.elementAt(i)['hours'].toString();
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  var id =   prefs.getString('uid');
                                  final conn = await MySqlConnection.connect(ConnectionSettings(
                                      host: 'greaseducks.com',
                                      port: 3306,
                                      user: 'grease_gdt',
                                      password: 'Yq4aOB9;NANh',
                                      db: 'grease_gd'));

                                  await conn.query("INSERT INTO gd_recently_viewed (type,element_id,user_id) VALUES ('account','${results.elementAt(i)['id'].toString()}','$id')");


                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(builder: (context) => Details(
                                      hours: hours,
                                      comName: results.elementAt(i)['company_name']??'N/A',
                                      suffix: '(${results.elementAt(i)['suffix']??'N/A'})',
                                      legalName: results.elementAt(i)['legal_business_name']??'N/A',
                                      uname: widget.uname,
                                      id: results.elementAt(i)['id'].toString()??'N/A',
                                      website: results.elementAt(i)['website'].toString()??'N/A',
                                      paymentType: results.elementAt(i)['preferred_payment'].toString()??'N/A',
                                      paymentTerms: results.elementAt(i)['payment_terms'].toString()??'N/A',
                                      type: results.elementAt(i)['type'].toString()??'N/A',
                                      industry: results.elementAt(i)['industry'].toString()??'N/A',
                                      status: results.elementAt(i)['status'].toString()??'N/A',
                                      image: results.elementAt(i)['image'].toString(),

                                    ),
                                    ),
                                  );
                                },
                              ),
                              Divider(),
                            ],
                          );
                        },

                      ),
                    ):Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),



          ],
        ),
      );
    }
    );

  }
}