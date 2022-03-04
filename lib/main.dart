import 'package:flutter/material.dart';

import 'package:flutter_complete_guide/provider/great_places.dart';
import 'package:flutter_complete_guide/screen/add_place_screen.dart';
import 'package:flutter_complete_guide/screen/place_list_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => PlacesListScreen(),
          AddPlaceScreen.routeName : (ctx) => AddPlaceScreen(),

        },
      ),
    );
  }
}
