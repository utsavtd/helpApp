import 'package:flutter/material.dart';
import 'package:help_app/config/app_settings.config.dart';
import 'package:help_app/screens/helpseeker_home.dart';
import 'package:help_app/screens/request_help.dart';
//import 'routes.dart';
import 'screens/home.dart';
import 'screens/register.dart';
import 'screens/forgot_password.dart';
import 'screens/help_list.dart';
import 'package:global_configuration/global_configuration.dart';


void main()  {
  GlobalConfiguration().loadFromMap(appSettings);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HelpApp',
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/help_list',
      routes: {
        '/register' :  (BuildContext context) =>  RegisterPage(),
        '/forgot_password' :  (BuildContext context) =>  ForgotPassword(),
        '/help_list' :  (BuildContext context) =>  HelpListPage(),
        '/help_seeker_home' :  (BuildContext context) =>  HelpSeekerHome(),
        '/request_help' :  (BuildContext context) =>  RequestHelp(),

        '/' :          (BuildContext context) =>  MyHomePage(),
      },
    );
  }
}


