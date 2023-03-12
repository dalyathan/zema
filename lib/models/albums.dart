import 'package:zema/models/super.dart';

class Albums extends SuperModel {
  final int id;
  final String albumName;
  final String albumDescription;
  final String albumCoverImage;
  final String artistName;

  Albums(this.id, this.albumName, this.albumDescription, this.albumCoverImage,
      this.artistName);
  static fromJson(dynamic json) {
    return Albums(
      json['id'],
      json['album_name'],
      json['album_description'],
      json['album_coverImage'],
      json['artist_name'],
    );
  }
}
