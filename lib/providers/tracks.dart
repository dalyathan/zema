import 'package:zema/models/favourites.dart';
import 'package:zema/models/tracks.dart';
import 'package:zema/providers/super.dart';

class TracksProvider extends SuperProvider<Tracks> {
  TracksProvider(super.next);

  Tracks findFavInTrackList(Favourites findMe) {
    return items.lastWhere((element) =>
        element.trackName == findMe.trackName &&
        element.trackDescription == findMe.trackDescription &&
        // element.trackCoverImage == findMe.trackCoverImage &&
        // element.trackAudioFile == findMe.trackAudioFile &&
        element.artistName == findMe.artistName &&
        element.albumName == findMe.albumName &&
        element.genreName == findMe.genreName);
  }
}
