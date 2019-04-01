import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Admin"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20.00, right: 20.00),
        child: Center(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),

              MaterialButton(
                elevation: 2.00,
                height: 80.00,
                minWidth: 150.00,
                color: Colors.teal,
                textColor: Colors.white,
                child: Text("View Help Requests",style: TextStyle(fontSize: 20.0)),
                onPressed: () {
                  _navigateTo('/help_list');
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),
              MaterialButton(
                elevation: 2.00,
                height: 80.00,
                minWidth: 150.00,
                color: Colors.teal,
                textColor: Colors.white,
                child: Text("Add Help Camp",style: TextStyle(fontSize: 20.0)),
                onPressed: () {
                  _navigateTo('/add_help_camp');
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),
              MaterialButton(
                elevation: 2.00,
                height: 80.00,
                minWidth: 150.00,
                color: Colors.teal,
                textColor: Colors.white,
                child: Text("Send Notification",style: TextStyle(fontSize: 20.0),),
                onPressed: () {
                  _navigateTo('/add_notification');
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _navigateTo(String routeName) {
    Navigator.of(context).pushNamed(routeName); //2
  }
}
