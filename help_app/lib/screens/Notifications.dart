import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:help_app/models/HelpNotification.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationListState();
}

class NotificationListState extends State<NotificationListPage> {

  Future<List<HelpNotification>> _getHelp() async {
    GlobalConfiguration cfg = new GlobalConfiguration();

    String _serviceUrl = cfg.getString('server') + '/notification/list/';


    var data = await http
        .get(_serviceUrl);

    var jsonHelp = json.decode(data.body);
    print(jsonHelp);

    List<HelpNotification> notifications = [];

    for (var h in jsonHelp) {
     // print("added"+h['user_id']['first_name']);

      HelpNotification notification =
      HelpNotification(h['_id'], h['text']);
      notifications.add(notification);
    }
    return notifications;
  }

  @override
  Widget build(BuildContext context) {

    var futureListBuilder = FutureBuilder(
      future: this._getHelp(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start.');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Text('Awaiting result...');
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon(Icons.notifications_active),
                    title: Text( " Notification by admin"),
                    subtitle: Text(snapshot.data[index].text,style:TextStyle(color: Colors.black45,fontSize: 18.0,fontWeight: FontWeight.bold)),
                    //trailing: Text(),
                  );
                });
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Container(child: futureListBuilder),
    );
  }
}
