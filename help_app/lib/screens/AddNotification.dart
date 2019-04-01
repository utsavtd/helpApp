import 'dart:io';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:help_app/models/HelpNotification.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geocoder/geocoder.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/HelpNotification.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationState();
}

class NotificationState extends State<NotificationPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController notificationController = TextEditingController();
  GlobalKey<FormState> addCampFormKey = GlobalKey();
  bool autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('New help camp'),
      ),
      body: Container(
          child: Form(
              key: addCampFormKey,
              autovalidate: autoValidate,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 30.0, left: 5.0, right: 5.0),
                    child: TextFormField(
                      maxLines: 4,
                      controller: notificationController,
                      decoration: InputDecoration(
                          labelText: "Notification text",
                          hintText: "Notification goes here",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Enter notification.";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                  ),
                  MaterialButton(
                    elevation: 2.00,
                    height: 50.00,
                    minWidth: 150.00,
                    color: Colors.teal,
                    textColor: Colors.white,
                    child: Text("Send notification"),
                    onPressed: addNotification,
                  ),
                ],
              )
          )
      ),
    );
  }

  void addNotification() async {
    autoValidate = true;

      if (addCampFormKey.currentState.validate()) {
        HelpNotification helpCamp = HelpNotification('', notificationController.text);
        helpCamp = await addNotificationRequest(helpCamp);
        if(helpCamp!=null){
          showMessage("Help camp added successfully");
          _navigateTo('/admin_home');


        }else{
          showMessage("Help camp couldnot be added. Please try again");

        }
      }
    }


  void _navigateTo(String routeName) {
    Navigator.of(context).pushNamed(routeName); //2
  }


  Future<HelpNotification> addNotificationRequest(HelpNotification helpCamp) async {

    GlobalConfiguration cfg = new GlobalConfiguration();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _serviceUrl = cfg.getString('server') + '/notification/create/';
    final _headers = {'Content-Type': 'application/json'};

    try {
      Map body = Map();
      body['text'] = helpCamp.text;

      var jsonBody = json.encode(body);
      final response =
          await http.post(_serviceUrl, headers: _headers, body: jsonBody);
      var c = json.decode(response.body);
      print(c['_id']);
      if (response.statusCode == 200) {
        helpCamp =
            HelpNotification(c['_id'], c['text']);
        showMessage("Notification sent");
        sleep(const Duration(seconds:3));
        _navigateTo('/admin_home');

        return helpCamp;
      } else {
        showMessage("Something went wrong. Please try again");
        return null;
      }
    } catch (e) {
      print('Server Exception!!!');
      print(e);
      return null;
    }
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }
}
