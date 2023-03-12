import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zema/components/common/music_player_dialog.dart';
import 'package:zema/constants.dart';
import 'package:zema/models/fav_track.dart';
import 'package:zema/providers/favourites.dart';
import 'package:zema/providers/tracks.dart';
import '../common/album.dart';
import '../common/lazy_list_view.dart';

class NewMusic extends StatelessWidget {
  const NewMusic({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    var albumWidth = size.width * 0.275;
    var albumHeight = size.height * 0.8;
    final favProvider = Provider.of<FavouritesProvider>(context, listen: true);
    return Consumer<TracksProvider>(
        builder: (_, data, __) => LazilyLoadingListView(
              size: size,
              content: data.items.map<Album>((e) {
                final isItFav = favProvider.isFav(e);
                return Album(
                  size: Size(albumWidth, albumHeight),
                  mainText: e.trackName,
                  supportingText: e.artistName,
                  icon: InkWell(
                    child: Icon(
                      isItFav ? Icons.favorite : Icons.favorite_outline,
                      color: isItFav ? pinkLike : Colors.grey,
                    ),
                    onTap: () {
                      if (isItFav) {
                        favProvider.remove(e).then((value) {
                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                successSnackBar('Successfully removed'));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                errorSnackBar('Unable to  remove'));
                          }
                        });
                      } else {
                        favProvider.add(e).then((value) {
                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                successSnackBar('Successfully added'));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(errorSnackBar('Unable to  add'));
                          }
                        });
                      }
                    },
                  ),
                  imageUrl: e.trackCoverImage,
                  onPlay: () async {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AudioPlayerDialog(track: FavTrack.fromTrack(e));
                      },
                    );
                  },
                );
              }),
              header: 'New Music',
              provider: data,
              scrollDirection: Axis.horizontal,
            ));
  }

  SnackBar snackBar(String messae, Color color) {
    return SnackBar(
      content: Text(
        messae,
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    );
  }

  SnackBar successSnackBar(String messae) {
    return snackBar(messae, Colors.green);
  }

  SnackBar errorSnackBar(String messae) {
    return snackBar(messae, Colors.red);
  }
}
