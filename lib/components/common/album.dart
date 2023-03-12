import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Album extends StatelessWidget {
  Album({
    super.key,
    required this.size,
    required this.mainText,
    required this.supportingText,
    required this.imageUrl,
    this.icon,
    this.onPlay,
  });
  final Size size;
  final String mainText;
  final String supportingText;
  final String imageUrl;
  final InkWell? icon;
  final VoidCallback? onPlay;
  @override
  Widget build(BuildContext context) {
    var cardHeight = size.height * 0.7;
    return GestureDetector(
      onTap: () => {
        if (onPlay != null) {onPlay!()}
      },
      child: Column(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                height: cardHeight,
                width: size.width,
                imageUrl: imageUrl,
              ),
              onPlay != null
                  ? SizedBox(
                      height: cardHeight,
                      width: size.width,
                      child: const Center(
                          child: Icon(Icons.play_circle_fill_outlined)),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            width: size.width,
            child: Row(
              children: [
                SizedBox(
                  width: size.width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        mainText,
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        supportingText,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                icon ?? Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}
