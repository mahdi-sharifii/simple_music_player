import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_play/features/home/presentation/bloc/home_bloc.dart';

import 'package:music_play/features/home/presentation/bloc/home_state.dart';
import 'package:music_play/features/home/presentation/bloc/home_songs_status.dart';
import 'package:music_play/features/home/presentation/helper/get_permission.dart';
import 'package:music_play/features/home/presentation/widget/failed_bar.dart';
import 'package:music_play/features/home/presentation/widget/my_progress_bar.dart';
import 'package:music_play/features/home/presentation/widget/my_sliver_appbar.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../widget/play_pause_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? idMusic;

  bool showImage = false;

  @override
  void initState() {
    super.initState();
    getPermission(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: CustomScrollView(slivers: [
        MySliverAppBar(size: size),
        SliverList(
          delegate: SliverChildListDelegate([
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.homeStatus is HomeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.homeStatus is HomeCompleted) {
                  final List<SongModel> songs =
                      (state.homeStatus as HomeCompleted).data;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      final SongModel song = songs[index];
                      // Create a player

                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: size.height * 0.004,
                            vertical: size.width * 0.01),
                        decoration: BoxDecoration(
                            color: ((state.playingStatus?.isPlay ?? false) &&
                                    state.playingStatus?.index == index)
                                ? const Color.fromARGB(255, 245, 229, 212)
                                : const Color.fromARGB(255, 250, 238, 222),
                            borderRadius: BorderRadius.circular(15)),
                        height: size.height * 0.15,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: AutoSizeText(song.album.toString()),
                                subtitle: AutoSizeText(song.artist.toString()),
                                trailing: SizedBox(
                                  height: size.width * 0.2,
                                  child: PlayPauseButton(
                                    index: index,
                                    dataSong: song.data,
                                    playing: ((state.playingStatus?.isPlay ??
                                            false) &&
                                        state.playingStatus?.index == index),
                                  ),
                                ),
                              ),
                              MyProgressBar(
                                index: index,
                                state: state,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                if (state.homeStatus is HomeEmpty) {
                  final String text = (state.homeStatus as HomeEmpty).message;
                  return Center(child: Text(text));
                }
                return const FailedPer();
              },
            ),
          ]),
        ),
      ]),
    );
  }
}
