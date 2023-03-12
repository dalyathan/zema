import 'package:zema/models/favourites.dart';
import 'package:zema/models/tracks.dart';
import 'package:zema/providers/super.dart';

import '../constants.dart';

class FavouritesProvider extends SuperProvider<Favourites> {
  FavouritesProvider(super.next);

  @override
  Future<void> getNextItems() async {
    await super.getNextItems();
    // items.forEach((element) => {print(element.userFUI)});
    items = items.where((element) => element.userFUI == userFUI).toList();
    notifyListeners();
  }

  Future<bool> add(Tracks newFav) async {
    final serverReponse = await networkService.addFavourite(newFav.id, userFUI);
    print(serverReponse);
    if (serverReponse['id']) {
      items = [
        ...items,
        Favourites(
            serverReponse['id'] as int,
            userFUI,
            newFav.trackName,
            newFav.trackDescription,
            newFav.trackCoverImage,
            newFav.trackAudioFile,
            newFav.artistName,
            newFav.albumName,
            newFav.genreName)
      ];
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> remove(Tracks removeMe) async {
    final fav = findTrackInFavList(removeMe);
    print(fav);
    if (fav != null) {
      final serverReponse =
          await networkService.deleteFavourite(fav.id, userFUI);
      if (serverReponse) {
        items = [...(items.where((element) => element.id != fav.id))];
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  isFav(Tracks checked) {
    final inFav = findTrackInFavList(checked);
    return inFav != null;
  }

  Favourites? findTrackInFavList(Tracks findMe) {
    final result = items.where((element) =>
        element.trackName == findMe.trackName &&
        element.trackDescription == findMe.trackDescription &&
        // element.trackCoverImage == findMe.trackCoverImage &&
        // element.trackAudioFile == findMe.trackAudioFile &&
        element.artistName == findMe.artistName &&
        element.albumName == findMe.albumName &&
        element.genreName == findMe.genreName);
    return result.isNotEmpty ? result.elementAt(0) : null;
  }
}
