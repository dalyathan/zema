import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zema/components/common/lazy_list_view.dart';
import 'package:zema/components/favourites_tab/favourite_row.dart';
import 'package:zema/providers/favourites.dart';
import 'package:zema/providers/tracks.dart';

class FavouritesTabBarView extends StatelessWidget {
  const FavouritesTabBarView({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    final trProvider = Provider.of<TracksProvider>(context);
    return Consumer<FavouritesProvider>(
        builder: (_, provider, __) => LazilyLoadingListView(
            size: size,
            content: provider.items.map(
              (e) => FavouritesRow(
                size: Size(size.width, size.height * 0.075),
                fav: e,
                provider: provider,
              ),
            ),
            header: 'My Favourites List',
            provider: provider,
            scrollDirection: Axis.vertical));
  }
}
