import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zema/components/common/music_player_dialog.dart';
import 'package:zema/constants.dart';
import 'package:zema/providers/favourites.dart';
import 'package:zema/providers/tracks.dart';
import '../common/album.dart';
import 'explore_row.dart';

class NewMusic extends StatelessWidget {
  const NewMusic({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    var albumWidth = size.width * 0.275;
    var albumHeight = size.height * 0.8;
    final favProvider = Provider.of<FavouritesProvider>(context);
    return Consumer<TracksProvider>(
        builder: (_, data, __) =>
            // data.items.isEmpty
            //     ? SizedBox(
            //         width: size.width,
            //         height: size.height,
            //         child: const Center(
            //           child: SizedBox.square(
            //               dimension: 32,
            //               child: CircularProgressIndicator(
            //                 color: pinkLike,
            //               )),
            //         ),
            //       )
            //     :
            ExploreRow(
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
                        favProvider.remove(e);
                      } else {
                        favProvider.add(e);
                      }
                    },
                  ),
                  imageUrl: e.trackCoverImage,
                  onPlay: () async {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AudioPlayerDialog(track: e);
                      },
                    );
                  },
                );
              }).toList(),
              header: 'New Music',
              provider: data,
            ));
  }
}
