import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zema/constants.dart';
import 'package:zema/models/fav_track.dart';
import 'package:zema/models/favourites.dart';
import 'package:zema/models/tracks.dart';

import '../../providers/favourites.dart';
import '../common/music_player_dialog.dart';

class FavouritesRow extends StatelessWidget {
  const FavouritesRow(
      {super.key,
      required this.size,
      required this.fav,
      required this.provider});
  final Size size;
  final Favourites fav;
  final FavouritesProvider provider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return AudioPlayerDialog(track: FavTrack.fromFav(fav));
        },
      ),
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Row(
          children: [
            ClipOval(
              child: CachedNetworkImage(
                  width: size.height * 0.66,
                  height: size.height * 0.66,
                  imageUrl: fav.trackCoverImage),
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(
                  flex: 2,
                ),
                Text(
                  fav.trackName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(
                  flex: 3,
                ),
                Text(
                  fav.artistName,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
            const Spacer(flex: 6),
            InkWell(
              child: Icon(
                Icons.favorite,
                color: pinkLike,
              ),
              onTap: () {
                // if (isItFav) {
                // provider.remove(fav);
                // } else {
                // favProvider.add(e);
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}
