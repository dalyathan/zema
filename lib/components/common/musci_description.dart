import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MusicDescription extends StatelessWidget {
  const MusicDescription(
      {super.key,
      required this.size,
      required this.coverImageUrl,
      required this.artistName,
      required this.trackName});
  final Size size;
  final String coverImageUrl;
  final String artistName;
  final String trackName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        CachedNetworkImage(
          imageUrl: coverImageUrl,
          width: size.width * 0.8,
          height: size.height * 0.8,
        ),
        Text(
          artistName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          trackName,
          style: const TextStyle(fontWeight: FontWeight.w200, fontSize: 10),
        )
      ]),
    );
  }
}
