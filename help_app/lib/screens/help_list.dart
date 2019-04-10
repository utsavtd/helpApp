import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:help_app/models/HelpRequests.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HelpListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HelpListState();
}

class HelpListState extends State<HelpListPage> {
  Future<List<HelpRequest>> _getHelp() async {
    GlobalConfiguration cfg = new GlobalConfiguration();

    String _serviceUrl = cfg.getString('server') + '/helprequests/list/';

    var data = await http.get(_serviceUrl);

    var jsonHelp = json.decode(data.body);
    print(jsonHelp);

    List<HelpRequest> helps = [];

    for (var h in jsonHelp) {
      print("added" + h['user_id']['first_name']);

      HelpRequest help = HelpRequest(
          h['_id'],
          h['type'],
          h['user_id']['first_name'] + ' ' + h['user_id']['last_name'],
          h['address']);
      helps.add(help);
    }
    return helps;
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
                    leading: Icon(Icons.person_pin),
                    title:
                        Text(snapshot.data[index].type + ' ' + " request", style: TextStyle(
                            color: Colors.red,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                        )),
                    subtitle:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                                 Text(snapshot.data[index].user,

                                ),

                            Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text("Address : "+snapshot.data[index].address,
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 15.0,
                                    )
                                )
                            ),


                          ],
                        )
                    //trailing: Padding(padding:EdgeInsets.all(10.0),child: ,),
                  );
                });
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Help List'),
      ),
      body: Container(child: futureListBuilder),
    );
  }
}
