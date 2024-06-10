import 'package:flutter/foundation.dart';
import 'package:flutter_app/core/error/exceptions.dart';
import 'package:flutter_app/features/song/data/models/song_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

// TODO: only download liked songs
abstract interface class SongLocalDataSource {
  void uploadLocalSongs({required List<SongModel> songs});
  Future<Uint8List> downloadImage(String url);
  List<SongModel> loadSongs();
}

class SongLocalDataSourceImpl implements SongLocalDataSource{
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
  Future<void> uploadLocalSongs({required List<SongModel> songs}) async {
    try {
      box.clear();
      for (int i = 0; i < songs.length; i++) {
        final song = songs[i];
        final imageUrl = song.image_path;
        Uint8List? imageData;

        if (imageUrl.isNotEmpty) {
          imageData = await downloadImage(imageUrl);
        }

        // Save song data
        final songData = song.copyWith(imageData: imageData).toJson();

        box.put(i.toString(), songData);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Uint8List> downloadImage(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception('Failed to download image');
      }
    } catch (e) {
      throw Exception('Failed to download image: $e');
    }
  }
}