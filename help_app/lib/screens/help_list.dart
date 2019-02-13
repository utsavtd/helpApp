import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HelpListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HelpListState();
}

class HelpListState extends State<HelpListPage> {
  Future<List<HelpRequest>> _getHelp() async {
    var data = await http
        .get('https://next.json-generator.com/api/json/get/41AuM-mV8');
    var jsonHelp = json.decode(data.body);
    List<HelpRequest> helps = [];

    for (var h in jsonHelp) {
      HelpRequest help =
          HelpRequest(h['_id'], h['company'], h['address'], h['about'],h['picture']);
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
                    title: Text(snapshot.data[index].title),
                    //subtitle: Text(snapshot.data[index].description),
                    trailing: Text("pending",style:TextStyle(color: Colors.red,fontSize: 18.0,fontWeight: FontWeight.bold)),
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

class HelpRequest {
  final String id;
  final String title;
  final String address;
  final String description;
  final String image;

  HelpRequest(this.id, this.title, this.address, this.description, this.image);

  HelpRequest.froJson(Map json):
    id=json['id'],
    title=json['title'],
    address=json['address'],
    description=json['description'],
    image=json['image'];


}
