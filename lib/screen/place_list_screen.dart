import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/provider/great_places.dart';
import 'package:flutter_complete_guide/screen/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Places..'), actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
          },
          icon: Icon(Icons.add),
        ),
      ]),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).getAndFetchSetData(),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting? Center(child: CircularProgressIndicator(),) : Consumer<GreatPlaces>(
          child: Center(
            child: Text('Got no places yet, start adding some!'),
          ),
          builder: (ctx, places, ch) => places.items.length <= 0
              ? ch
              : ListView.builder(
                  itemBuilder: (ctx, i) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(places.items[i].image),
                    ),
                     title: Text(places.items[i].title),
                     onTap: () {
                       
                     },
                  ),
                  itemCount: places.items.length,
                ),
        ),
      ),
    );
  }
}
