import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zema/components/common/lazy_list_view.dart';

import '../../providers/albums.dart';
import '../common/album.dart';

class NewAlbums extends StatelessWidget {
  const NewAlbums({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    var albumWidth = size.width * 0.55;
    var albumHeight = size.height * 0.8;
    return Consumer<AlbumsProvider>(
        builder: (_, provider, __) => LazilyLoadingListView(
              size: size,
              content: //[
                  provider.items.map<Album>((e) => Album(
                        size: Size(albumWidth, albumHeight),
                        mainText: e.albumName,
                        supportingText: e.artistName,
                        icon: const InkWell(
                            child: Icon(
                          Icons.more_vert,
                        )),
                        imageUrl: e.albumCoverImage,
                      )),
              header: 'New Albums',
              provider: provider,
              scrollDirection: Axis.horizontal,
            ));
  }
}
