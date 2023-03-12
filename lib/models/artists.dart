import 'package:zema/models/super.dart';

class Artists extends SuperModel {
  final int id;
  final String artistName;
  final String artistDescription;
  final String artistProfileImage;

  Artists(
      this.id, this.artistName, this.artistDescription, this.artistProfileImage)
      : super();
  static fromJson(dynamic json) {
    return Artists(
      json['id'],
      json['artist_name'],
      json['artist_description'],
      json['artist_profileImage'],
    );
  }
}
