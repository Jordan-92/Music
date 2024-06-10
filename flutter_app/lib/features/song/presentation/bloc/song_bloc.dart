import 'dart:ffi';
import 'dart:io';
import 'package:flutter_app/core/usecase/usecase.dart';
import 'package:flutter_app/features/song/domain/entities/song.dart';
import 'package:flutter_app/features/song/domain/usecases/dislike_song.dart';
import 'package:flutter_app/features/song/domain/usecases/get_all_songs.dart';
import 'package:flutter_app/features/song/domain/usecases/get_liked_song.dart';
import 'package:flutter_app/features/song/domain/usecases/is_liked_song.dart';
import 'package:flutter_app/features/song/domain/usecases/like_song.dart';
import 'package:flutter_app/features/song/domain/usecases/upload_song.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'song_event.dart';
part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final UploadSong _uploadSong;
  final GetAllSongs _getAllSongs;
  final GetLikedSongs _getLikedSongs;
  final LikeSong _likeSong;
  final DislikeSong _dislikeSong;
  final IsLikedSong _isLikedSong;

  SongBloc({
    required UploadSong uploadSong,
    required GetAllSongs getAllSongs,
    required GetLikedSongs getLikedSongs,
    required LikeSong likeSong,
    required DislikeSong dislikeSong,
    required IsLikedSong isLikedSong,
  })  : _uploadSong = uploadSong,
        _getAllSongs = getAllSongs,
        _getLikedSongs = getLikedSongs,
        _likeSong = likeSong,
        _dislikeSong = dislikeSong,
        _isLikedSong = isLikedSong,
        super(SongInitial()) {
    on<SongEvent>((event, emit) => emit(SongLoading()));
    on<SongUpload>(_onSongUpload);
    on<SongFetchAllSongs>(_onFetchAllSongs);
    on<SongFetchLikedSongs>(_onFetchLikedSongs);
    on<SongLike>(_onSongLike);
    on<SongDislike>(_onSongDislike);
    on<SongIsLiked>(_onSongIsLiked);
  }

  void _onSongUpload(
    SongUpload event,
    Emitter<SongState> emit,
  ) async {
    const duration = Duration(seconds: 150); // TODO: Use event.duration for duration
    final res = await _uploadSong(
      UploadSongParams(
        user_id: event.user_id,
        title: event.title,
        author: event.author,
        image: event.image,
        mp3: event.mp3,
        language: event.language,
        duration: duration,
      ),
    );

    res.fold(
      (l) => emit(SongFailure(l.message)),
      (r) => emit(SongUploadSuccess()),
    );
  }

  void _onFetchAllSongs(
    SongFetchAllSongs event,
    Emitter<SongState> emit,
  ) async {
    final res = await _getAllSongs(NoParams());

    res.fold(
      (l) => emit(SongFailure(l.message)),
      (r) => emit(SongsDisplaySuccess(r)),
    );
  }

  void _onFetchLikedSongs(
    SongFetchLikedSongs event,
    Emitter<SongState> emit,
  ) async {
    final res = await _getLikedSongs(NoParams());

    res.fold(
      (l) => emit(SongFailure(l.message)),
      (r) => emit(SongsDisplaySuccess(r)),
    );
  }

  void _onSongLike(
    SongLike event,
    Emitter<SongState> emit,
  ) async {
    final res = await _likeSong(LikeSongParams(songId: event.songId));

    res.fold(
      (l) => emit(SongFailure(l.message)),
      (r) => emit(SongLikeSuccess()),
    );
  }

  void _onSongDislike(
    SongDislike event,
    Emitter<SongState> emit,
  ) async {
    final res = await _dislikeSong(DislikeSongParams(songId: event.songId));

    res.fold(
      (l) => emit(SongFailure(l.message)),
      (r) => emit(SongDislikeSuccess()),
    );
  }

  void _onSongIsLiked(
    SongIsLiked event,
    Emitter<SongState> emit,
  ) async {
    final res = await _isLikedSong(IsLikedSongParams(songId: event.songId));

    res.fold(
      (l) => emit(SongFailure(l.message)),
      (r) => emit(SongIsLikedSuccess(r)),
    );
  }
}
