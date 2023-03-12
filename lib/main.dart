import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zema/components/tabs.dart';
import 'package:zema/constants.dart';
import 'package:zema/providers/albums.dart';
import 'package:zema/providers/artists.dart';
import 'package:zema/providers/favourites.dart';
import 'package:zema/providers/tracks.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AlbumsProvider(ALBUMS_API_URL)),
    ChangeNotifierProvider(create: (_) => TracksProvider(TRACKS_API_URL)),
    ChangeNotifierProvider(create: (_) => ArtistsProvider(ARTISTS_API_URL)),
    ChangeNotifierProvider(
        create: (_) => FavouritesProvider(FAVOURITES_API_URL)),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return MaterialApp(
      home: SafeArea(
        child: MainTab(containerSize: size),
      ),
    );
  }
}
