import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grease_ducks/details.dart';
import 'package:grease_ducks/widgets/text.dart';
import 'package:mysql1/mysql1.dart';

class RecentlyViewed extends StatefulWidget {
  final String uname;
  final String uid;

  const RecentlyViewed({Key key, this.uname, this.uid}) : super(key: key);


  @override
  _RecentlyViewedState createState() => _RecentlyViewedState();
}

class _RecentlyViewedState extends State<RecentlyViewed> {

  Results recentlyViewed;

  getRecentlyViewed(BuildContext context,String query) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'greaseducks.com',
        port: 3306,
        user: 'grease_gdt',
        password: 'Yq4aOB9;NANh',
        db: 'grease_gd'));

    // Query the database using a parameterized query

    recentlyViewed = await conn.query(query);
    setState(() {});
    for(var row in recentlyViewed){
      print(row['company_name']);
    }

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecentlyViewed(context, "SELECT * FROM `gd_recently_viewed` AS `r`INNER JOIN gd_accounts ON (gd_accounts.`id` = `element_id`)WHERE `r`.`type`='account' AND `r`.`user_id` = '${widget.uid}' GROUP BY `r`.`element_id` ORDER BY max(`r`.`id`) DESC LIMIT 10");

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Label(size: 20,text: 'Recently Viewed',color: Colors.white,),
      ),

      body: recentlyViewed!=null?ListView.builder(
        physics: ScrollPhysics(),

        shrinkWrap: true,
        itemCount: recentlyViewed!=null?recentlyViewed.length:0,

        itemBuilder: (context,i){

          var suffix = recentlyViewed.elementAt(i)['suffix'];
          var finalSuffix = suffix!=''?'($suffix)':'';

          var name = recentlyViewed.elementAt(i)['company_name']+' $finalSuffix';

          return Column(
            children: <Widget>[
              ListTile(
                dense: true,
                title: Label(text: name,),
                onTap: (){

                  String hours = recentlyViewed.elementAt(i)['hours'].toString();
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => Details(hours: hours,comName: recentlyViewed.elementAt(i)['company_name'],uname: widget.uname,id: recentlyViewed.elementAt(i)['id'].toString(),)),
                  );
                },
              ),
              Divider(),
            ],
          );
        },

      ):Center(child: CircularProgressIndicator(),),
    );
  }
}
