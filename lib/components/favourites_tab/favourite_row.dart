import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zema/model/tracks.dart';

import '../common/music_player_dialog.dart';

class FavouritesRow extends StatelessWidget {
  const FavouritesRow(
      {super.key,
      required this.size,
      required this.isFavourite,
      required this.track});
  final Size size;
  final Tracks track;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return AudioPlayerDialog(track: track);
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
                  imageUrl: track.trackCoverImage),
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
                  track.trackName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(
                  flex: 3,
                ),
                Text(
                  track.artistName,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
            const Spacer(flex: 6),
            Icon(
              isFavourite ? Icons.favorite : Icons.favorite_outline,
              size: size.height * 0.4,
              color: isFavourite ? Colors.white : Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
