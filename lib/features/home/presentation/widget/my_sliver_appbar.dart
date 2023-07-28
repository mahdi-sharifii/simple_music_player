import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:music_play/features/home/presentation/bloc/home_bloc.dart';
import 'package:music_play/features/home/presentation/bloc/home_songs_status.dart';
import 'package:music_play/features/home/presentation/bloc/home_state.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MySliverAppBar extends StatelessWidget {
  const MySliverAppBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        pinned: true,
        floating: true,
        backgroundColor: Colors.transparent,
        expandedHeight: 250.0,
        flexibleSpace: FlexibleSpaceBar(title: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.homeStatus is HomeCompleted) {
              List<SongModel> songs = (state.homeStatus as HomeCompleted).data;
              return state.playingStatus?.index != null
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: size.width * 0.4,
                        child: Marquee(
                          fadingEdgeEndFraction: 0.5,
                          fadingEdgeStartFraction: 0.5,
                          pauseAfterRound: const Duration(seconds: 3),
                          startAfter: const Duration(seconds: 1),
                          crossAxisAlignment: CrossAxisAlignment.end,
                          text:
                              "        ${songs[state.playingStatus!.index!].title}        ",
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ),
                    )
                  : const Text("");
            }
            return const SizedBox();
          },
        ), background: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.homeStatus is HomeCompleted) {
              List songs = (state.homeStatus as HomeCompleted).data;
              return state.playingStatus?.index != null
                  ? QueryArtworkWidget(
                      artworkFit: BoxFit.cover,
                      artworkBorder: BorderRadius.zero,
                      id: songs[state.playingStatus!.index!].id,
                      type: ArtworkType.AUDIO,
                    )
                  : const Text("");
            }
            return const SizedBox();
          },
        )));
  }
}
