import 'dart:async';
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:help_app/models/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> signInFormKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String type = "help seeker";
  bool autoValidate=false;

  var _userType = ['help seeker', 'helper', 'admin'];
  var _currentUserType = 'help seeker';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20.00, right: 20.00),
        child: ListView(
          children: <Widget>[
            Container(
              width: 150.00,
              height: 150.00,
              margin: EdgeInsets.only(top: 40.00),
              child: Center(
                  child: Image(
                image: AssetImage('images/logo.png'),
                width: 150.0,
                height: 150.0,
              )),
            ),
            Form(
                key: signInFormKey,
                autovalidate: autoValidate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 50.00),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Enter email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        keyboardType: TextInputType.emailAddress,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Enter a valid email.";
                          }
                          String pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regExp = new RegExp(pattern);
                          if (!regExp.hasMatch(value)) {
                            return "Invalid Email";
                          }
                        },
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
                            return "Please enter password with more than 5 chars";
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
                      child: Text("Login"),
                      onPressed: _submitLoginForm,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: GestureDetector(
                          onTap: () => _navigateTo('/register'),
                          child: Text(
                            'Register',
                            style:
                                TextStyle(fontSize: 18.00, color: Colors.teal),
                          ),
                        )),
                        Expanded(
                            child: GestureDetector(
                          onTap: () => _navigateTo('/forgot_password'),
                          child: Text(
                            'Forgot Password?.',
                            style:
                                TextStyle(fontSize: 18.00, color: Colors.teal),
                          ),
                        ))
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void _navigateTo(String routeName) {
    Navigator.of(context).pushNamed(routeName); //2
  }

  void _submitLoginForm() async {
    autoValidate=true;
    if (signInFormKey.currentState.validate()) {
      User user=User('','','',emailController.text,passwordController.text,type);
       user =await Login(user);

    }
  }

  Future<User> Login(User user) async {
    GlobalConfiguration cfg = new GlobalConfiguration();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String _serviceUrl=cfg.getString('server')+'/users/signIn/';
    final _headers = {'Content-Type': 'application/json'};

    try {
      Map body=Map();
      body['email']=user.email;
      body['password']=user.password;
      body['type']=user.type;

      var jsonBody=json.encode(body);
      final response =
      await http.post(_serviceUrl, headers: _headers, body: jsonBody);
      if (response.statusCode == 200) {
        var c = json.decode(response.body);
        user=User.fromJson(c['payload']);
        print('userid');
        print(user.id);
        prefs.setString('id', user.id);
        prefs.setString('first_name', user.first_name);
        prefs.setString('last_name', user.last_name);
        prefs.setString('type', user.type);
        prefs.setString('email', user.email);

        if(user.type=="help seeker"){

          _navigateTo('/help_seeker_home');

        }
        if(user.type=="helper"){

          _navigateTo('/helper_home');

        }
        if(user.type=="admin"){

          _navigateTo('/admin_home');

        }
        return user;
      }else
        {
          showMessage("Invalid login");
          return null;

        }

    } catch (e) {
      print('Server Exception!!!');
      print(e);
      return null;
    }
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(backgroundColor: color, content: new Text(message)));
  }
}
