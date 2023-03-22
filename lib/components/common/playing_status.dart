import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:zema/constants.dart';

class PlayingStatus extends StatefulWidget {
  const PlayingStatus({super.key, required this.player, required this.size});
  final AudioPlayer player;
  final Size size;

  @override
  State<PlayingStatus> createState() => _PlayingStatusState();
}

class _PlayingStatusState extends State<PlayingStatus> {
  double seekingDistance = 0;
  @override
  Widget build(BuildContext context) {
    final barWidth = widget.size.width * 0.8;
    final seekerOuterDiameter = widget.size.width * 0.0475;
    final seekerInnerDiameter = seekerOuterDiameter * 0.5;
    return StreamBuilder<Duration>(
        stream: widget.player.positionStream,
        builder: (BuildContext context, AsyncSnapshot<Duration?> snapshot) {
          String remainingMinuteValue;
          String minusRemainingMinuteValue;
          double percentIndicator = 0;
          if (snapshot.hasError || snapshot.data == null) {
            remainingMinuteValue = minusRemainingMinuteValue = '---';
          } else {
            remainingMinuteValue = snapshot.data.toString().split('.')[0];
            minusRemainingMinuteValue = widget.player.duration != null
                ? Duration(
                        milliseconds: (snapshot.data!.inMilliseconds -
                            widget.player.duration!.inMilliseconds))
                    .toString()
                    .split('.')[0]
                : '---';
            percentIndicator = widget.player.duration != null
                ? snapshot.data!.inMicroseconds /
                    widget.player.duration!.inMicroseconds
                : 0;
          }
          return Container(
            width: widget.size.width,
            height: widget.size.height,
            color: Colors.amber,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(
                  flex: 3,
                ),
                Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    SizedBox(
                      width: barWidth,
                      child: Center(
                        child: LinearProgressIndicator(
                          value: percentIndicator,
                          semanticsLabel: 'Linear progress indicator',
                          color: pinkLike,
                          backgroundColor: pinkLike.withOpacity(0.3),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: ((barWidth * percentIndicator -
                                      seekerOuterDiameter / 2) >
                                  0
                              ? (barWidth * percentIndicator -
                                  seekerOuterDiameter / 2)
                              : 0)),
                      child: GestureDetector(
                          onPanStart: (details) {
                            setState(() {
                              seekingDistance = details.localPosition.dx;
                            });
                          },
                          onPanUpdate: (d) async {
                            setState(() {
                              seekingDistance = seekingDistance + d.delta.dx;
                            });
                          },
                          onPanEnd: (d) async {
                            if (snapshot.data != null) {
                              final changeRatio = (seekingDistance / barWidth);
                              int newDurationInMicros =
                                  snapshot.data!.inMicroseconds +
                                      (widget.player.duration!.inMicroseconds *
                                              (changeRatio))
                                          .toInt();
                              final newDuration =
                                  Duration(microseconds: newDurationInMicros);
                              await widget.player.seek(newDuration);
                              setState(() {
                                seekingDistance = 0;
                              });
                            }
                          },
                          onPanCancel: () {
                            setState(() {
                              seekingDistance = 0;
                            });
                          },
                          child: Stack(
                            alignment: AlignmentDirectional.centerStart,
                            children: [
                              Container(
                                width: seekerOuterDiameter,
                                height: seekerOuterDiameter,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.blue),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: (seekerOuterDiameter -
                                            seekerInnerDiameter) *
                                        0.5),
                                child: Container(
                                  width: seekerInnerDiameter,
                                  height: seekerInnerDiameter,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                ),
                              )
                            ],
                          )),
                    ),
                  ],
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
