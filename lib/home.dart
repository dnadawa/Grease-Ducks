import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grease_ducks/accounts.dart';
import 'package:grease_ducks/widgets/text.dart';

import 'login.dart';

class HomePage extends StatefulWidget {
  final String uname;

  const HomePage({Key key, this.uname}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{


  CupertinoTabController _tabController;

  @override
  void initState() {
    _tabController = new CupertinoTabController(initialIndex: 0);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        controller: _tabController,
        tabBar: CupertinoTabBar(
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.grey.shade200,
            items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Container(
              width: 30,
              height: 30,
              child: Image.asset('images/accounts.png'))),
          BottomNavigationBarItem(icon: Container(
              width: 30,
              height: 30,
              child: Image.asset('images/contacts.png'))),
          BottomNavigationBarItem(icon: Container(
              width: 30,
              height: 30,
              child: Image.asset('images/cal.png'))),
        ]),


        tabBuilder: (BuildContext context, int index){
              if(index == 0){
                return Welcome(uname: widget.uname,);
              }else if(index == 1){
                return Accounts(uname: widget.uname,);
              }
              else if(index == 2){
                return LogIn();
              }else{
                return LogIn();
              }
        });
  }
}


class Welcome extends StatelessWidget {
  final String uname;

  const Welcome({Key key, this.uname}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(
          width: double.infinity,
          height: 30,
          color: Theme.of(context).primaryColor,
          child: Align(
              alignment: Alignment.topRight,
              child: Label(text: 'Welcome $uname',color: Colors.white,)),
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
                  Label(color: Colors.white,text: 'Dashboard',size: 25,)
                ],
              ),
            ),
          ),


          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(35),
                  child: Image.asset('images/logo.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(35),
                  child: Label(text: 'New Staff Notification',color: Colors.red,size: 18,),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Label(
                    color: Colors.grey,
                    text: 'Please remember to "Triple Check" that all tools and supplies are returned to the truck after every job.  We have had numerous items including tools etc. go missing and this affects everyone.  We are only good as the tools we have when we need them!\n\nAlso, tools are being left in the bed of the truck.  This is not where they belong, nor can anyone find them there.  Tools that come from the tool box are to be returned to the tool box!\n\n~MGMT',),
                )

              ],
            ),
          ),


        ],
      ),
    );
  }
}
