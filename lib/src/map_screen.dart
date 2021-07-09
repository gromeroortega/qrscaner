import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrscanner/Models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Es el future que contiene el controller de maps
  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    //Marcadores
    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
        markerId: MarkerId('geo-location'), position: scan.getLatLng()));

    //Posición inicical de la camara
    final CameraPosition startingPoint = CameraPosition(
      target: scan.getLatLng(),
      zoom: 18,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ubicación'),
        actions: [
          IconButton(
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(target: scan.getLatLng(), zoom: 18)));
              },
              icon: Icon(Icons.pin_drop))
        ],
      ),
      body: GoogleMap(
        mapType: mapType,
        markers: markers,
        initialCameraPosition: startingPoint,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.layers),
          onPressed: () {
            //Redibuja el stafull widget
            setState(() {
              if (mapType == MapType.normal) {
                mapType = MapType.hybrid;
              } else {
                mapType = MapType.normal;
              }
            });
          }),
    );
  }
}
