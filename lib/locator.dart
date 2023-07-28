import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton<OnAudioQuery>(OnAudioQuery());
  getIt.registerSingleton<AudioPlayer>(AudioPlayer());
}
