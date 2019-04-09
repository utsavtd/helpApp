import 'dart:io';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:help_app/models/HelpCamp.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geocoder/geocoder.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HelpCampPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HelpCampState();
}

class HelpCampState extends State<HelpCampPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> addCampFormKey = GlobalKey();
  bool autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
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
                      controller: nameController,
                      decoration: InputDecoration(
                          labelText: "Help camp name",
                          hintText: "Enter camp name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      keyboardType: TextInputType.emailAddress,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Enter a valid camp name.";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0, left: 5.0, right: 5.0),
                    child: TextFormField(
                      maxLines: 4,
                      controller: descriptionController,
                      decoration: InputDecoration(
                          labelText: "Help camp description",
                          hintText: "Enter Help camp description",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Enter Help camp description.";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0, left: 5.0, right: 5.0),
                    child: TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                          labelText: "Help camp address",
                          hintText: "Enter Help camp address",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      keyboardType: TextInputType.emailAddress,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Enter help camp address.";
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
                    child: Text("Add Help Camp"),
                    onPressed: addHelpCamp,
                  ),
                ],
              ))),
    );
  }

  void addHelpCamp() async {
    autoValidate = true;
    final query = addressController.text;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    if (addresses.length == 0) {
      showMessage("Invalid address. Please try again");
    } else {
      var first = addresses.first;
      print("this is ${first.featureName} : ${first.coordinates.latitude}");

      if (addCampFormKey.currentState.validate()) {
        HelpCamp helpCamp = HelpCamp('', nameController.text, descriptionController.text, addressController.text, first.coordinates.latitude, first.coordinates.longitude);
        helpCamp = await addHelpCampRequest(helpCamp);
        if(helpCamp!=null){
          sleep(const Duration(seconds:3));
          SharedPreferences prefs = await SharedPreferences.getInstance();
          print(prefs.getString('type'));

          if(prefs.getString('type')=='admin'){
            _navigateTo('/admin_home');

          }else{
            _navigateTo('/helper_home');

          }


        }else{
          showMessage("Help camp couldnot be added. Please try again");

        }
      }
    }
  }
  void _navigateTo(String routeName) {
    Navigator.of(context).pushNamed(routeName); //2
  }


  Future<HelpCamp> addHelpCampRequest(HelpCamp helpCamp) async {
    GlobalConfiguration cfg = new GlobalConfiguration();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _serviceUrl = cfg.getString('server') + '/helpcamp/create/';
    final _headers = {'Content-Type': 'application/json'};

    try {
      Map body = Map();
      body['name'] = helpCamp.name;
      body['description'] = helpCamp.description;
      body['address'] = helpCamp.address;
      body['lat'] = helpCamp.lat;
      body['lang'] = helpCamp.lang;

      var jsonBody = json.encode(body);
      final response =
          await http.post(_serviceUrl, headers: _headers, body: jsonBody);
      var c = json.decode(response.body);
      print(c['_id']);
      if (response.statusCode == 200) {
        helpCamp =
            HelpCamp(c['_id'], c['name'], c['description'], c['address'], null, null);
        showMessage("Help camp added");

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
