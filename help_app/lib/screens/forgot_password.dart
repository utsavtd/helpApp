import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20.00, right: 20.00),
        child: Center(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),
              Text("Please enter your email to receive instructions on how to recover your password.",
                style: TextStyle(fontSize: 16.00),),
              Form(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.00),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Enter email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      keyboardType: TextInputType.emailAddress,
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
                    child: Text("Submit"),
                    onPressed: () {},
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  void _navigateTo(String routeName) {
    Navigator.of(context).pushNamed('/register'); //2
  }
}
