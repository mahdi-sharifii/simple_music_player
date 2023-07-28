


import 'package:on_audio_query/on_audio_query.dart';

abstract class HomeStatus {}

class HomeInitial extends HomeStatus {}
class HomeLoading extends HomeStatus{}
class HomeCompleted extends HomeStatus{
  final List<SongModel> data ;
  HomeCompleted(this.data);
}
class HomeEmpty extends HomeStatus{
  final String message;
  HomeEmpty(this.message);
}

