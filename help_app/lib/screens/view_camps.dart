import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

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
    List<LatLng> campList = [
      LatLng(43.6532, -79.3832),
      LatLng(43.7013812, -79.4108814),
      LatLng(43.6598275, -79.364916),
    ];
    for (int i = 0; i < campList.length; i++) {
      mapController.addMarker(MarkerOptions(
          position: LatLng(campList[i].latitude, campList[i].longitude),
          draggable: false,
          infoWindowText: InfoWindowText('Help Camp', 'Help camp info')));
    }
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
                    onMapCreated: _onMapCreated,
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

  void _onMapCreated(GoogleMapController controller) {
    print('_onMapCreated');

    setState(() {
      print('set stte called');
      mapController = controller;
      addMarkers();
    });
  }
}
