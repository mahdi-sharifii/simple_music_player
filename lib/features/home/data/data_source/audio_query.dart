import 'package:on_audio_query/on_audio_query.dart';

import '../../../../locator.dart';

class AudioQuery {
  static Future<List<SongModel>> getSongs() async {
    List<SongModel> albums = await getIt<OnAudioQuery>().querySongs();
    return albums;
  }
}
