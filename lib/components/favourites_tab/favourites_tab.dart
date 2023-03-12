import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zema/components/favourites_tab/favourite_row.dart';
import 'package:zema/providers/favourites.dart';

class FavouritesTabBarView extends StatelessWidget {
  const FavouritesTabBarView({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouritesProvider>(
        builder: (_, data, __) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Favourites List',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: data.favs.isNotEmpty ? size.height * 0.85 : 0,
                  child: ListView.separated(
                    itemBuilder: (context, index) => FavouritesRow(
                        size: Size(size.width, size.height * 0.075),
                        track: data.favs[index],
                        isFavourite: true),
                    itemCount: data.favs.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                  ),
                ),
                data.favs.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'No items',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.grey),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ));
  }
}
