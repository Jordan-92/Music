import 'dart:io';
import 'package:flutter_app/core/usecase/usecase.dart';
import 'package:flutter_app/features/song/domain/entities/song.dart';
import 'package:flutter_app/features/song/domain/usecases/get_all_songs.dart';
import 'package:flutter_app/features/song/domain/usecases/get_liked_song.dart';
import 'package:flutter_app/features/song/domain/usecases/upload_song.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'song_event.dart';
part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final UploadSong _uploadSong;
  final GetAllSongs _getAllSongs;
  final GetLikedSongs _getLikedSongs;
  SongBloc({
    required UploadSong uploadSong,
    required GetAllSongs getAllSongs,
    required GetLikedSongs getLikedSongs,
  })  : _uploadSong = uploadSong,
        _getAllSongs = getAllSongs,
        _getLikedSongs = getLikedSongs,
        super(SongInitial()) {
    on<SongEvent>((event, emit) => emit(SongLoading()));
    on<SongUpload>(_onSongUpload);
    on<SongFetchAllSongs>(_onFetchAllSongs);
    on<SongFetchLikedSongs>(_onFetchLikedSongs);
  }

  void _onSongUpload(
    SongUpload event,
    Emitter<SongState> emit,
  ) async {
    const duration = Duration(seconds: 150);// TODO: Use event.duration for duration
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
}