import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class ViewCamps extends StatefulWidget {
  @override
  _ViewCampsState createState() => _ViewCampsState();
}

class _ViewCampsState extends State<ViewCamps> {
  GoogleMapController mapController;

  bool showMap = false;

  void initState() {
    super.initState();
    print("initial position");

    showMap = true;
  }

  addMarkers() {
    GlobalConfiguration cfg = new GlobalConfiguration();

    String _serviceUrl = cfg.getString('server') + '/helpcamp/list/';


    http.get(_serviceUrl).then((value){
      var jsonCamp = json.decode(value.body);
      print(jsonCamp);
      for (var helpCamp in jsonCamp) {
        mapController.addMarker(MarkerOptions(
            position: LatLng(helpCamp['lat'], helpCamp['lang']),
            draggable: false,
            infoWindowText: InfoWindowText(helpCamp['name'], helpCamp['address'])));
      }

    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Camps"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 80.0,
            width: MediaQuery.of(context).size.width,
            child: showMap
                ? GoogleMap(
                    mapType: MapType.normal,
                    onMapCreated:  _onMapCreated,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(43.6532, -79.3832), zoom: 12),
                  )
                : Center(
                    child: Text("Loding Map"),
                  ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller)  {
    print('_onMapCreated');

    setState(() {
      print('set state called');
      mapController = controller;
       addMarkers();
    });
  }
}
