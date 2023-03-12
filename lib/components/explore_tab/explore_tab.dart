import 'package:flutter/material.dart';
import 'package:zema/components/explore_tab/new_album.dart';
import 'package:zema/components/explore_tab/new_artists.dart';
import 'package:zema/components/explore_tab/new_music.dart';

class ExploreTabBarView extends StatelessWidget {
  const ExploreTabBarView({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    // var albumListViewHeight = widget.size.height * 0.175;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(
          flex: 1,
        ),
        NewAlbums(size: Size(size.width - 2, size.height * 0.2)),
        const Spacer(
          flex: 2,
        ),
        NewMusic(size: Size(size.width - 2, size.height * 0.175)),
        const Spacer(
          flex: 2,
        ),
        NewArtists(size: Size(size.width - 2, size.height * 0.175)),
        const Spacer(
          flex: 6,
        )
      ],
    );
  }
}
