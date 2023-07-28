
import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_play/features/home/presentation/bloc/home_play_pause.dart';

import 'package:music_play/features/home/presentation/bloc/home_songs_status.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../locator.dart';
import '../../data/data_source/audio_query.dart';
import 'home_state.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int? _nowIndex;
  HomeBloc() : super(HomeState(homeStatus: HomeInitial())) {
    on<GetAllSongEvent>((event, emit) async {
      emit(state.copyWith(newHomeStatus: HomeLoading()));
      List<SongModel> songs = List.empty();
      try {
        songs = await AudioQuery.getSongs();
        if (songs.isNotEmpty) {
          emit(state.copyWith(newHomeStatus: HomeCompleted(songs)));
        } else {
          emit(state.copyWith(newHomeStatus: HomeEmpty("Empty")));
        }
      } catch (e) {
        emit(state.copyWith(newHomeStatus: HomeEmpty("Error")));
      }
    });
    on<PlayPauseEvent>((event, emit) async {
      if (event.dataSong == null) {
        emit(state.copyWith(
            newPlayingStatus: PlayingStatus(isPlay: false, index: null)));
      } else if (_nowIndex != event.index) {
        await getIt<AudioPlayer>().setFilePath(event.dataSong!);
        getIt<AudioPlayer>().play();
      } else {
        print("gggggggggggggggggggggggggggggggggggggggggggggggggggggggg");
        getIt<AudioPlayer>().playing
            ? getIt<AudioPlayer>().pause()
            : getIt<AudioPlayer>().play();
      }
      _nowIndex = event.index;
      emit(state.copyWith(
          newPlayingStatus: PlayingStatus(
              isPlay: (getIt<AudioPlayer>().playing), index: _nowIndex)));
    });
  }
}
