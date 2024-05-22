import 'dart:io';
import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/core/usecase/usecase.dart';
import 'package:flutter_app/features/song/domain/entities/song.dart';
import 'package:flutter_app/features/song/domain/repositories/song_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadSong implements UseCase<Song, UploadSongParams> {
  final SongRepository songRepository;
  UploadSong(this.songRepository);

  @override
  Future<Either<Failure, Song>> call(UploadSongParams params) async {
    return await songRepository.uploadSong(
      image: params.image,
      mp3: params.mp3,
      title: params.title,
      author: params.author,
      user_id: params.user_id,
      language: params.language,
    );
  }
}

class UploadSongParams {
  final String user_id;
  final String title;
  final String author;
  final File image;
  final File mp3;
  final String language;

  UploadSongParams({
    required this.user_id,
    required this.title,
    required this.author,
    required this.image,
    required this.mp3,
    required this.language,
  });
}