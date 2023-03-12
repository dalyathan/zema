import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zema/providers/artists.dart';

import '../common/lazy_list_view.dart';

class NewArtists extends StatelessWidget {
  const NewArtists({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Consumer<ArtistsProvider>(
        builder: (_, data, __) => LazilyLoadingListView(
              size: size,
              content: // [
                  data.items.map<Column>((e) => Column(
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                                width: size.height * 0.66,
                                height: size.height * 0.66,
                                imageUrl: e.artistProfileImage),
                          ),
                          Text(e.artistName)
                        ],
                      )),
              header: 'New Artists',
              provider: data,
              scrollDirection: Axis.horizontal,
            ));
  }
}
