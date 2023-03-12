import 'package:flutter/foundation.dart';
import 'package:zema/model/tracks.dart';

class FavouritesProvider with ChangeNotifier {
  List<Tracks> favs = [];

  add(Tracks newFav) {
    favs = [...favs, newFav];
    notifyListeners();
  }

  remove(Tracks newFav) {
    favs = favs.where((element) => element.id != newFav.id).toList();
    notifyListeners();
  }

  isFav(Tracks checked) {
    return favs.indexWhere((element) => element.id == checked.id) != -1;
  }
}
