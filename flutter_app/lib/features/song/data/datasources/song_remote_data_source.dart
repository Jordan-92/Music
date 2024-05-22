import 'dart:io';

import 'package:flutter_app/core/error/exceptions.dart';
import 'package:flutter_app/features/song/data/models/song_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

abstract interface class SongRemoteDataSource {
  Future<SongModel> uploadSong(SongModel song);
  Future<String> uploadSongImage({
    required File image,
    required SongModel song,
  });
  Future<String> uploadSongMP3({
    required File mp3,
    required SongModel song,
  });
  Future<List<SongModel>> getAllSongs();
}

class SongRemoteDataSourceImpl implements SongRemoteDataSource {
  final uniqueID = const Uuid().v1();
  final SupabaseClient supabaseClient;
  SongRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<SongModel> uploadSong(SongModel song) async {
    try {
      final songData =
          await supabaseClient.from('songs').insert(song.toJson()).select();

      return SongModel.fromJson(songData.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadSongImage({
    required File image,
    required SongModel song,
  }) async {
    try {
      String imageName = "image-${song.title}-$uniqueID";
      await supabaseClient.storage.from('images').upload(
            imageName,
            image,
          );

      return supabaseClient.storage.from('images').getPublicUrl(
            imageName,
          );
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadSongMP3({
    required File mp3,
    required SongModel song,
  }) async {
    try {
      String songName = "song-${song.title}-$uniqueID";
      await supabaseClient.storage.from('songs').upload(
            songName,
            mp3,
          );

      return supabaseClient.storage.from('songs').getPublicUrl(
            songName,
          );
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<SongModel>> getAllSongs() async {
    try {
      final songs = await supabaseClient.from('songs').select('*');
      return songs
          .map(
            (song) => SongModel.fromJson(song),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
