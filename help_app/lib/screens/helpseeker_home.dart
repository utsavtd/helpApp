import 'package:flutter/material.dart';

class HelpSeekerHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HelpSeekerHomeState();
}

class _HelpSeekerHomeState extends State<HelpSeekerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Help Seeker"),
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
                child: Text("Send Help Request",style: TextStyle(fontSize: 20.0)),
                onPressed: () {
                  _navigateTo('/request_help');
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
                child: Text("View Camps",style: TextStyle(fontSize: 20.0)),
                onPressed: () {
                  _navigateTo('/view_camps');
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
                child: Text("View Notifications",style: TextStyle(fontSize: 20.0),),
                onPressed: () {
                  _navigateTo('/list_notifications');
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
