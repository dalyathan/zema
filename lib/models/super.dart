import 'package:zema/models/albums.dart';
import 'package:zema/models/artists.dart';
import 'package:zema/models/tracks.dart';

import 'favourites.dart';

abstract class SuperModel {
  static T fromJson<T extends SuperModel>(dynamic json) {
    switch (T) {
      case Albums:
        return Albums.fromJson(json) as T;
      case Artists:
        return Artists.fromJson(json) as T;
      case Tracks:
        return Tracks.fromJson(json) as T;
      case Favourites:
        return Favourites.fromJson(json) as T;
      default:
        throw UnimplementedError();
    }
  }
}
