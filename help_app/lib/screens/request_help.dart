import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:help_app/models/HelpRequests.dart';
import 'package:help_app/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestHelp extends StatefulWidget {
  @override
  _RequestHelpState createState() => _RequestHelpState();
}

class _RequestHelpState extends State<RequestHelp> {
  double timeDilation = 1.0;
  bool foodCheckBoxValue = true;
  bool shelterCheckBoxValue = false;
  bool clothCheckBoxValue = false;
  String currentlySelectedHelpRequest = "food";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('Request Help'),
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5.0),
                color: Colors.teal,
                height: 90.0,
                child: Text(
                  'Following helps are available. Please choose one.',
                  style: TextStyle(fontSize: 30.00, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 25.00,
              ),
              CheckboxListTile(
                title: const Text(
                  'Food',
                  style: TextStyle(fontSize: 25.00),
                ),
                value: foodCheckBoxValue,
                onChanged: (bool value) {
                  setState(() {
                    currentlySelectedHelpRequest = "food";
                    foodCheckBoxValue = value;
                    if (value == true) {
                      clothCheckBoxValue = false;
                      shelterCheckBoxValue = false;
                    }
                  });
                },
                secondary: const Icon(Icons.fastfood),
              ),
              SizedBox(
                height: 25.00,
              ),
              CheckboxListTile(
                title: const Text(
                  'Cloth',
                  style: TextStyle(fontSize: 25.00),
                ),
                value: clothCheckBoxValue,
                onChanged: (bool value) {
                  setState(() {
                    currentlySelectedHelpRequest = "cloth";
                    clothCheckBoxValue = value;
                    if (value == true) {
                      foodCheckBoxValue = false;
                      shelterCheckBoxValue = false;
                    }
                  });
                },
                secondary: const Icon(Icons.person),
              ),
              SizedBox(
                height: 25.00,
              ),
              CheckboxListTile(
                title: const Text(
                  'Shelter',
                  style: TextStyle(fontSize: 25.00),
                ),
                value: shelterCheckBoxValue,
                onChanged: (bool value) {
                  setState(() {
                    currentlySelectedHelpRequest = "shelter";
                    shelterCheckBoxValue = value;
                    if (value == true) {
                      foodCheckBoxValue = false;
                      clothCheckBoxValue = false;
                    }
                  });
                },
                secondary: const Icon(Icons.home),
              ),
              SizedBox(
                height: 5.00,
              ),
              Form(
                  key: key,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.00,bottom: 10.00),
                    child: TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                          labelText: "Address",
                          hintText: "Enter address",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.length < 1) {
                          return "Please enter address";
                        }
                      },
                    ),
                  )
              ),
              MaterialButton(
                elevation: 5.00,
                height: 50.00,
                minWidth: 150.00,
                color: Colors.teal,
                textColor: Colors.white,
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 20.00),
                ),
                onPressed: _CreateHelpRequest,
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _CreateHelpRequest() async {

    if (key.currentState.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await SendHelpRequest(
          prefs.getString('id'), currentlySelectedHelpRequest,addressController.text);
    }
  }

  Future<String> SendHelpRequest(String user_id, String helpRequest,address) async {
    GlobalConfiguration cfg = new GlobalConfiguration();
    final _headers = {'Content-Type': 'application/json'};

    String _serviceUrl = cfg.getString('server') + '/helprequests/create/';
    Map body = Map();
    body['user_id'] = user_id;
    body['type'] = helpRequest;
    body['address'] = address;
    var jsonBody = json.encode(body);
    final response =
        await http.post(_serviceUrl, headers: _headers, body: jsonBody);
    if (response.statusCode == 200) {
      showMessage("Help requested succesfully");
      setState(() {
        foodCheckBoxValue = true;
        shelterCheckBoxValue = false;
        clothCheckBoxValue = false;
        currentlySelectedHelpRequest = "";
      });
    } else {
      showMessage("help request failed");
      return null;
    }
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }
}
