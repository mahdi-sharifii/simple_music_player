import 'home_play_pause.dart';
import 'package:music_play/features/home/presentation/bloc/home_songs_status.dart';

class HomeState {
  HomeStatus homeStatus;
  PlayingStatus? playingStatus;

  HomeState({required this.homeStatus, this.playingStatus});

  HomeState copyWith(
      {HomeStatus? newHomeStatus, PlayingStatus? newPlayingStatus}) {
    return HomeState(
        homeStatus: newHomeStatus ?? homeStatus,
        playingStatus: newPlayingStatus ?? playingStatus);
  }
}
