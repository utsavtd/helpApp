import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestHelp extends StatefulWidget {
  @override
  _RequestHelpState createState() => _RequestHelpState();
}

class _RequestHelpState extends State<RequestHelp> {
  double timeDilation=1.0;
  bool foodCheckBoxValue = false;
  bool shelterCheckBoxValue = false;
  bool clothCheckBoxValue = false;
  String currentlySelectedHelpRequest="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Help'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    currentlySelectedHelpRequest="food";
                    foodCheckBoxValue = value;
                    if(value==true){
                      clothCheckBoxValue=false;
                      shelterCheckBoxValue=false;
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
                    currentlySelectedHelpRequest="cloth";
                    clothCheckBoxValue = value;
                    if(value==true){
                      foodCheckBoxValue=false;
                      shelterCheckBoxValue=false;
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
                    currentlySelectedHelpRequest="shelter";
                    shelterCheckBoxValue = value;
                    if(value==true){
                      foodCheckBoxValue=false;
                      clothCheckBoxValue=false;
                    }

                  });
                },
                secondary: const Icon(Icons.home),
              ),
              SizedBox(
                height: 5.00,
              ),
              MaterialButton(
                elevation: 5.00,
                height: 50.00,
                minWidth: 150.00,
                color: Colors.teal,
                textColor: Colors.white,
                child: Text("Submit",style: TextStyle(fontSize: 20.00),),
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

 void  _CreateHelpRequest() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   print(prefs.getString('id'));
   print(currentlySelectedHelpRequest);



  }
}
