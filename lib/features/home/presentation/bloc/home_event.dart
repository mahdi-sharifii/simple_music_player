part of 'home_bloc.dart';


abstract class HomeEvent {}

class GetAllSongEvent extends HomeEvent {}
class PlayPauseEvent extends HomeEvent{
  int? index;
  String? dataSong;
  PlayPauseEvent(this.index, this.dataSong);
}