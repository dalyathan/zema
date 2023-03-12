import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:zema/constants.dart';

class PausePlay extends StatefulWidget {
  const PausePlay({
    super.key,
    required this.player,
  });
  final AudioPlayer player;

  @override
  State<PausePlay> createState() => _PausePlayState();
}

class _PausePlayState extends State<PausePlay>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration?>(
        stream: widget.player.durationStream,
        builder: (BuildContext context, AsyncSnapshot<Duration?> snapshot) {
          if (snapshot.hasError || snapshot.data == null) {
            return const SizedBox.square(
                dimension: 32,
                child: CircularProgressIndicator(
                  color: pinkLike,
                ));
          } else {
            return InkWell(
                onTap: () async {
                  if (widget.player.duration != null) {
                    if (widget.player.playing) {
                      widget.player.pause();
                      // controller.animateBack(1);
                    } else {
                      widget.player.play();
                      // controller.animateTo(0);
                    }
                  }
                },
                child: StreamBuilder<bool>(
                  stream: widget.player.playingStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasError || snapshot.data == null) {
                      return const SizedBox.square(
                          dimension: 32, child: CircularProgressIndicator());
                    }
                    if (widget.player.playing) {
                      // widget.player.pause();
                      controller.animateBack(1);
                    } else {
                      // widget.player.play();
                      controller.animateTo(0);
                    }
                    return Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: pinkLike),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: AnimatedIcon(
                          icon: AnimatedIcons.play_pause,
                          color: Colors.white,
                          progress: animation,
                          size: 32,
                          semanticLabel: 'Show menu',
                        ),
                      ),
                    );
                  },
                ));
          }
        });
  }
}
