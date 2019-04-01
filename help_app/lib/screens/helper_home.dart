import 'package:flutter/material.dart';

class HelperHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HelperHomeState();
}

class _HelperHomeState extends State<HelperHome> {
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
                child: Text("View Notifications",style: TextStyle(fontSize: 20.0),),
                onPressed: () {},
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
