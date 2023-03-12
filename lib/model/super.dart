import 'package:zema/model/albums.dart';
import 'package:zema/model/artists.dart';
import 'package:zema/model/tracks.dart';

abstract class SuperModel {
  static T fromJson<T extends SuperModel>(dynamic json) {
    switch (T) {
      case Albums:
        return Albums.fromJson(json) as T;
      case Artists:
        return Artists.fromJson(json) as T;
      case Tracks:
        return Tracks.fromJson(json) as T;
      default:
        throw UnimplementedError();
    }
  }
}
