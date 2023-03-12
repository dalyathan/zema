import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:zema/constants.dart';

class PlayingStatus extends StatelessWidget {
  const PlayingStatus({super.key, required this.player, required this.size});
  final AudioPlayer player;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
        stream: player.positionStream,
        builder: (BuildContext context, AsyncSnapshot<Duration?> snapshot) {
          String remainingMinuteValue;
          String minusRemainingMinuteValue;
          double percentIndicator = 0;
          if (snapshot.hasError || snapshot.data == null) {
            remainingMinuteValue = minusRemainingMinuteValue = '---';
          } else {
            remainingMinuteValue = snapshot.data.toString().split('.')[0];
            minusRemainingMinuteValue = player.duration != null
                ? Duration(
                        milliseconds: (snapshot.data!.inMilliseconds -
                            player.duration!.inMilliseconds))
                    .toString()
                    .split('.')[0]
                : '---';
            percentIndicator = player.duration != null
                ? snapshot.data!.inMicroseconds /
                    player.duration!.inMicroseconds
                : 0;
          }
          return SizedBox(
            width: size.width * 0.8,
            height: size.height * 0.8,
            child: Column(
              children: [
                const Spacer(
                  flex: 3,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: LinearProgressIndicator(
                    value: percentIndicator,
                    semanticsLabel: 'Linear progress indicator',
                    color: pinkLike,
                    backgroundColor: pinkLike.withOpacity(0.3),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(remainingMinuteValue),
                    Text(minusRemainingMinuteValue),
                  ],
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
          );
        });
  }
}
