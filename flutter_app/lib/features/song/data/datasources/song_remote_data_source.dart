import 'dart:io';
import 'package:flutter_app/core/error/exceptions.dart';
import 'package:flutter_app/features/song/data/models/song_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

abstract class SongRemoteDataSource {
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
  Future<List<SongModel>> getLikedSongs();
  Future<void> likeSong(int songId);
  Future<void> dislikeSong(int songId);
  Future<bool> isSongLiked(int songId);
}

class SongRemoteDataSourceImpl implements SongRemoteDataSource {
  final uniqueID = const Uuid().v1();
  final SupabaseClient supabaseClient;

  SongRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<SongModel> uploadSong(SongModel song) async {
    try {
      final response = await supabaseClient
          .from('songs')
          .insert(song.toJson())
          .select()
          .single();
          
      return SongModel.fromJson(response);
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
      final response = await supabaseClient.from('songs').select('*');
      return (response as List<dynamic>)
          .map(
            (song) => SongModel.fromJson(song as Map<String, dynamic>),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<SongModel>> getLikedSongs() async {
    try {
      final user = supabaseClient.auth.currentUser;

      if (user == null) {
        throw const ServerException('User not logged in');
      }

      final userId = user.id;

      final response = await supabaseClient
          .from('liked_songs')
          .select('*, songs(*)')
          .eq('user_id', userId);

      final likedSongs = response as List<dynamic>;

      return likedSongs
          .map((song) => SongModel.fromJson(song['songs'] as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<void> likeSong(int songId) async {
    try {
      final user = supabaseClient.auth.currentUser;

      if (user == null) {
        throw const ServerException('User not logged in');
      }

      await supabaseClient.from('liked_songs').insert({
        'user_id': user.id,
        'song_id': songId,
      });
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> dislikeSong(int songId) async {
    try {
      final user = supabaseClient.auth.currentUser;

      if (user == null) {
        throw const ServerException('User not logged in');
      }

      await supabaseClient
          .from('liked_songs')
          .delete()
          .eq('user_id', user.id)
          .eq('song_id', songId);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<bool> isSongLiked(int songId) async {
    try {
      final user = supabaseClient.auth.currentUser;

      if (user == null) {
        throw const ServerException('User not logged in');
      }

      final response = await supabaseClient
          .from('liked_songs')
          .select()
          .eq('user_id', user.id)
          .eq('song_id', songId)
          .single();

      // ignore: unnecessary_null_comparison
      return response != null;
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        return false;
      }
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}