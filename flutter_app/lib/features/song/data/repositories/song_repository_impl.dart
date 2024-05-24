import 'dart:io';
import 'package:flutter_app/core/error/exceptions.dart';
import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/core/constants/constants.dart';
import 'package:flutter_app/core/network/connection_checker.dart';
import 'package:flutter_app/features/song/data/datasources/song_local_data_source.dart';
import 'package:flutter_app/features/song/data/datasources/song_remote_data_source.dart';
import 'package:flutter_app/features/song/data/models/song_model.dart';
import 'package:flutter_app/features/song/domain/entities/song.dart';
import 'package:flutter_app/features/song/domain/repositories/song_repository.dart';
import 'package:fpdart/fpdart.dart';

class SongRepositoryImpl implements SongRepository {
  final SongRemoteDataSource songRemoteDataSource;
  final SongLocalDataSource songLocalDataSource;
  final ConnectionChecker connectionChecker;
  SongRepositoryImpl(
    this.songRemoteDataSource,
    this.songLocalDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, Song>> uploadSong({
    required File image,
    required File mp3,
    required String author,
    required String title,
    required String user_id,
    required String language,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      SongModel songModel = SongModel(
        user_id: user_id,
        title: title,
        author: author,
        image_path: '',
        song_path: '',
        language: language,
      );

      final imageUrl = await songRemoteDataSource.uploadSongImage(
        image: image,
        song: songModel,
      );

      songModel = songModel.copyWith(
        image_path: imageUrl,
      );

      final songUrl = await songRemoteDataSource.uploadSongMP3(
        mp3: mp3,
        song: songModel,
      );

      songModel = songModel.copyWith(
        song_path: songUrl,
      );


      final uploadedSong = await songRemoteDataSource.uploadSong(songModel);
      return right(uploadedSong);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Song>>> getAllSongs() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final songs = songLocalDataSource.loadSongs();
        if (songs.isEmpty) {
          return left(Failure('No local songs available'));
        }
        return right(songs);
      }
      final songs = await songRemoteDataSource.getAllSongs();
      songLocalDataSource.uploadLocalSongs(songs: songs); //TODO: remove it when it's will be streaming
      return right(songs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}