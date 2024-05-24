import 'package:flutter/foundation.dart';
import 'package:flutter_app/features/song/data/models/song_model.dart';
import 'package:hive/hive.dart';
// TODO: only download liked songs
abstract interface class SongLocalDataSource {
  void uploadLocalSongs({required List<SongModel> songs});
  List<SongModel> loadSongs();
}

class SongLocalDataSourceImpl implements SongLocalDataSource {
  final Box box;
  SongLocalDataSourceImpl(this.box);

  @override
  List<SongModel> loadSongs() {
    try {
      List<SongModel> songs = [];
      for (int i = 0; i < box.length; i++) {
        final songJson = box.get(i.toString());
        if (songJson != null) {
          songs.add(SongModel.fromJson(songJson));
        }
      }
      return songs;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading songs from local storage: $e');
      }
      return [];
    }
  }

  @override
  void uploadLocalSongs({required List<SongModel> songs}) {
    try {
      box.clear();
      for (int i = 0; i < songs.length; i++) {
        box.put(i.toString(), songs[i].toJson());
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading songs to local storage: $e');
      }
    }
  }
}