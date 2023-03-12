import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zema/components/common/lazy_grid_view.dart';
import 'package:zema/constants.dart';
import 'package:zema/providers/albums.dart';
import '../common/album.dart';

class AllAlbumsTabBarView extends StatelessWidget {
  const AllAlbumsTabBarView({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    var albumWidth = size.width * 0.35;
    return Consumer<AlbumsProvider>(
      builder: (_, data, __) => LazyLoadingVerticalListView(
          data: data,
          size: size,
          content: data.items.map((e) => Album(
                size: Size(albumWidth, albumWidth),
                mainText: e.albumName,
                supportingText: e.albumDescription,
                imageUrl: e.albumCoverImage,
              )),
          header: 'All Albums'),
    );
  }
}
