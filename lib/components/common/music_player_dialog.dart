import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:zema/components/common/musci_description.dart';
import 'package:zema/components/common/pause_play_icon.dart';
import 'package:zema/components/common/playing_status.dart';
import 'package:zema/models/fav_track.dart';

class AudioPlayerDialog extends StatefulWidget {
  const AudioPlayerDialog({
    super.key,
    required this.track,
  });
  final FavTrack track;

  @override
  State<AudioPlayerDialog> createState() => _AudioPlayerDialogState();
}

class _AudioPlayerDialogState extends State<AudioPlayerDialog> {
  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setUrl(widget.track.trackAudioFile);
  }

  @override
  void dispose() async {
    super.dispose();
    final currentVolume = player.volume;
    const divider = 50;
    for (var i = divider; i >= 1; i--) {
      await player.setVolume(currentVolume * ((i / divider)));
    }
    await player.stop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 4,
          ),
          MusicDescription(
              size: Size(size.width, size.height * 0.3),
              artistName: widget.track.artistName,
              coverImageUrl: widget.track.trackCoverImage,
              trackName: widget.track.trackName),
          const Spacer(),
          SizedBox(
              width: size.width * 0.8,
              child: PlayingStatus(
                  player: player, size: Size(size.width, size.height * 0.1))),
          const Spacer(),
          PausePlay(player: player),
          const Spacer(
            flex: 4,
          ),
        ],
      ),
    );
  }
}
