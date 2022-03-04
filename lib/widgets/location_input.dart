import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screen/google_maps.dart';
import 'package:location/location.dart';
import '../helpers/location_helper.dart';
import 'package:latlong2/latlong.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImage;

  Future<void> getUsersLocation() async {
    final locationData = await Location().getLocation();
    final staticImageUrl = LocationHelper.generatePreviewImageUrl(
      latitude: locationData.latitude,
      longitude: locationData.longitude,
    );

    setState(() {
      _previewImage = staticImageUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    print(selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 170,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: _previewImage == null
            ? Text(
                'No Location Chosen!',
                textAlign: TextAlign.center,
              )
            : Image.network(
                _previewImage,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
      ),
      SizedBox(height: 10),
      Row(
        children: [
          RaisedButton.icon(
            onPressed: getUsersLocation,
            icon: Icon(Icons.location_on_sharp),
            label: Text(
              'Current Location',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          RaisedButton.icon(
            onPressed: _selectOnMap,
            icon: Icon(Icons.maps_home_work),
            label: Text(
              'Select on Map',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        ],
      ),
    ]);
  }
}
