// import 'package:flutter_complete_guide/models/place.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';

// class MapScreen extends StatefulWidget {
// final PlaceLocation initialLocation;
// final bool isSelecting;

// MapScreen({this.initialLocation = const PlaceLocation(longitude: 37.4442, latitude: -122.43, ), this.isSelecting = false});
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(
//         'Your Maps'
//       ),),
//       body: MapboxMap(initialCameraPosition: CameraPosition(target: LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude) , zoom: 16)),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen(
      {this.initialLocation = const PlaceLocation(
        longitude: 37.4442,
        latitude: -122.43,
      ),
      this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocationMap(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chose From Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: _pickedLocation == null
                    ? null
                    : () {
                        Navigator.of(context).pop(_pickedLocation);
                      },
                icon: Icon(Icons.check))
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(widget.initialLocation.longitude,
              widget.initialLocation.latitude),
          zoom: 13.0,
          onTap: widget.isSelecting? _selectLocationMap : Null,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/rugvedkute/ckwhf26v518es14pj5hj34rj9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicnVndmVka3V0ZSIsImEiOiJja3dnNzVlNWQwbHcwMnduc215emljcjNjIn0.pl_U8H2QwkKfbRLUX52Gxg',
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoicnVndmVka3V0ZSIsImEiOiJja3dnNzVlNWQwbHcwMnduc215emljcjNjIn0.pl_U8H2QwkKfbRLUX52Gxg',
              'id': 'mapbox.mapbox-streets-v8',
            },
          ),
          MarkerLayerOptions(
            markers: _pickedLocation == null? [] : [
              Marker(point: _pickedLocation, builder: (ctx) => Container(
                child: Icon(Icons.location_on),
              ),)
            ]
          )
        ],
      ),
    );
  }
}
