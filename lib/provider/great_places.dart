import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'dart:io';
import '../helpers/db_helper.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Places> _items = [];

  List<Places> get items {
    return [..._items];
  }

  void addPlaces(String pickedTitle, File pickedImage) {
    final newPlace = Places(
        id: DateTime.now().toString(),
        image: pickedImage,
        title: pickedTitle,
        location: null);
    _items.add(newPlace);
    notifyListeners();
    DbHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> getAndFetchSetData() async {
    final dataList = await DbHelper.getData('user_places');
    _items = dataList
        .map(
          (items) => Places(
            id: items['id'],
            title: items['title'],
            location: null,
            image: File(
              items['image'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
