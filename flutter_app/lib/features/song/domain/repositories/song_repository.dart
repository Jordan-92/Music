import 'dart:io';

import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/features/song/domain/entities/song.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class SongRepository {
  Future<Either<Failure, Song>> uploadSong({
    required File image,
    required File mp3,
    required String title,
    required String author,
    required String user_id,
    required String language,
    required Duration duration,

  });

  Future<Either<Failure, List<Song>>> getAllSongs();
  Future<Either<Failure, List<Song>>> getLikedSongs();
}