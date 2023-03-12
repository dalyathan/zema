import 'package:zema/models/super.dart';

class Favourites extends SuperModel {
  final int id;
  final String userFUI;
  final String trackName;
  final String trackDescription;
  final String trackCoverImage;
  final String trackAudioFile;
  final String artistName;
  final String albumName;
  final String genreName;

  Favourites(
      this.id,
      this.userFUI,
      this.trackName,
      this.trackDescription,
      this.trackCoverImage,
      this.trackAudioFile,
      this.artistName,
      this.albumName,
      this.genreName);
  static fromJson(dynamic json) {
    return Favourites(
      json['id'],
      json['user_FUI'],
      json['track_name'],
      json['track_description'],
      json['track_coverImage'],
      json['track_audioFile'],
      json['artist_name'],
      json['album_name'],
      json['genre_name'],
    );
  }
}
