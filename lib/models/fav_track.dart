import 'package:zema/models/favourites.dart';
import 'package:zema/models/tracks.dart';

class FavTrack {
  final String trackName;
  final String trackDescription;
  final String trackCoverImage;
  final String trackAudioFile;
  final String artistName;
  final String albumName;
  final String genreName;
  FavTrack(this.trackName, this.trackDescription, this.trackCoverImage,
      this.trackAudioFile, this.artistName, this.albumName, this.genreName);
  factory FavTrack.fromTrack(Tracks tr) {
    return FavTrack(tr.trackName, tr.trackDescription, tr.trackCoverImage,
        tr.trackAudioFile, tr.artistName, tr.albumName, tr.genreName);
  }

  factory FavTrack.fromFav(Favourites tr) {
    return FavTrack(tr.trackName, tr.trackDescription, tr.trackCoverImage,
        tr.trackAudioFile, tr.artistName, tr.albumName, tr.genreName);
  }
}
