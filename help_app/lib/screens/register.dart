import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:help_app/models/User.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String type = "help seeker";
  var _userType = ['help seeker', 'helper', 'admin'];
  var _currentUserType = 'help seeker';
  TextEditingController first_nameController = TextEditingController();
  TextEditingController last_nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20.00, right: 20.00),
        child: ListView(
          children: <Widget>[
            Container(
              width: 120.00,
              height: 120.00,
              margin: EdgeInsets.only(top: 20.00),
              child: Center(
                  child: Image(
                image: AssetImage('images/logo.png'),
                width: 150.0,
                height: 150.0,
              )),
            ),
            Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30.00),
                      child: TextFormField(
                        controller: first_nameController,

                        decoration: InputDecoration(
                            labelText: "First name",
                            hintText: "Enter first name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        keyboardType: TextInputType.text,
                        validator: (String value) {
                          if (value.length < 1) {
                            return "Please enter first name";
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.00),
                      child: TextFormField(
                        controller: last_nameController,

                        decoration: InputDecoration(
                            labelText: "Last name",
                            hintText: "Enter last name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        keyboardType: TextInputType.text,
                        validator: (String value) {
                          if (value.length < 1) {
                            return "Please enter last name";
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.00),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Enter email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        keyboardType: TextInputType.emailAddress,
                        validator: (String value) {
                          if (value.length < 1) {
                            return "Please enter email";
                          }
                          String pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regExp = new RegExp(pattern);
                          if (!regExp.hasMatch(value)) {
                            return "Invalid Email";
                          }
                        },
                        controller: emailController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.00),
                      child: TextFormField(
                        controller: passwordController,

                        decoration: InputDecoration(
                            hintText: "Enter password",
                            labelText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        validator: (String value) {
                          if (value.length < 5) {
                            return "Please enter password with more than 6 chars";
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        //isDense: true,
                        hint: Text("Select login type"),
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                        iconSize: 35.0,
                        items: _userType.map((String UserTypeItem) {
                          return DropdownMenuItem<String>(
                            child: new Container(
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[new Text(UserTypeItem)],
                              ),
                            ),
                            value: UserTypeItem,
                          );
                        }).toList(),
                        onChanged: (String selectedUserType) {
                          setState(() {
                            type = selectedUserType;
                            this._currentUserType = selectedUserType;
                          });
                        },
                        value: _currentUserType,
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
                      child: Text("Register"),
                      onPressed: RegisterUser,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void RegisterUser() async {
    if (key.currentState.validate()) {
      print(type);
      User user = User(
      '', first_nameController.text, last_nameController.text, emailController.text, passwordController.text, type);
      user = await Register(user);
    }
  }

  void _navigateTo(String routeName) {
    Navigator.of(context).pushNamed(routeName); //2
  }

  Future<User> Register(User user) async {
    GlobalConfiguration cfg = new GlobalConfiguration();

    String _serviceUrl=cfg.getString('server')+'/users/signUp/';

    final _headers = {'Content-Type': 'application/json'};

    try {
      Map body = Map();
      body['email'] = user.email;
      body['password'] = user.password;
      body['first_name'] = user.first_name;
      body['last_name'] = user.last_name;
      body['type'] = user.type;

      var jsonBody = json.encode(body);
      final response =
          await http.post(_serviceUrl, headers: _headers, body: jsonBody);
      if (response.statusCode == 200) {
        var c = User.fromJson(json.decode(response.body));
        showMessage("Registered succesfully");
        setState(() {
          first_nameController.text='';
          last_nameController.text='';
          emailController.text='';
          passwordController.text='';

        });
        } else {
        showMessage("Registration failed");
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
