import 'package:flutter/material.dart';
import 'package:help_app/config/app_settings.config.dart';
import 'package:help_app/screens/admin_home.dart';
import 'package:help_app/screens/helper_home.dart';
import 'package:help_app/screens/helpseeker_home.dart';
import 'package:help_app/screens/request_help.dart';
import 'package:help_app/screens/view_camps.dart';
import 'package:help_app/screens/helpcamp.dart';
//import 'routes.dart';
import 'screens/home.dart';
import 'screens/register.dart';
import 'screens/forgot_password.dart';
import 'screens/help_list.dart';
import 'screens/AddNotification.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:help_app/screens/Notifications.dart';


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
      initialRoute: 'view_camps',
      routes: {
        '/register' :  (BuildContext context) =>  RegisterPage(),
        '/forgot_password' :  (BuildContext context) =>  ForgotPassword(),
        '/help_list' :  (BuildContext context) =>  HelpListPage(),
        '/add_help_camp' :  (BuildContext context) =>  HelpCampPage(),
        '/help_seeker_home' :  (BuildContext context) =>  HelpSeekerHome(),
        '/request_help' :  (BuildContext context) =>  RequestHelp(),
        '/view_camps' :  (BuildContext context) =>  ViewCamps(),
        '/helper_home' :  (BuildContext context) =>  HelperHome(),
        '/admin_home' :  (BuildContext context) =>  AdminHome(),
        '/add_notification' :  (BuildContext context) =>  NotificationPage(),
        '/list_notifications' :  (BuildContext context) =>  NotificationListPage(),



        '/' :          (BuildContext context) =>  MyHomePage(),
      },
    );
  }
}


