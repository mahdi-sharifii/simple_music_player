import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_play/features/home/presentation/bloc/home_bloc.dart';
import 'package:music_play/features/home/presentation/bloc/home_state.dart';
import 'package:music_play/locator.dart';

class MyProgressBar extends StatelessWidget {
  const MyProgressBar({
    super.key,
    required this.index,
    required this.state,
  });
  final int index;
  final HomeState state;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Visibility(
      visible: ((state.playingStatus?.isPlay ?? false) &&
          state.playingStatus?.index == index),
      child: StreamBuilder(
        stream: getIt<AudioPlayer>().positionStream,
        builder: (context, _) {
          if (getIt<AudioPlayer>().position.inSeconds.round() ==
              getIt<AudioPlayer>().duration?.inSeconds.round()) {
            state.playingStatus?.index = null;
            BlocProvider.of<HomeBloc>(context).add(PlayPauseEvent(null, null));
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child: ProgressBar(
              onSeek: (value) {
                getIt<AudioPlayer>().seek(value);
              },
              thumbColor: const Color.fromARGB(255, 140, 125, 102),
              baseBarColor: const Color.fromARGB(150, 140, 125, 102),
              progressBarColor: const Color.fromARGB(255, 140, 125, 102),
              progress: getIt<AudioPlayer>().position,
              total: getIt<AudioPlayer>().duration ?? Duration.zero,
            ),
          );
        },
      ),
    );
  }
}
