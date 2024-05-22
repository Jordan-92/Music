import 'dart:io';
import 'package:flutter_app/core/usecase/usecase.dart';
import 'package:flutter_app/features/song/domain/entities/song.dart';
import 'package:flutter_app/features/song/domain/usecases/get_all_songs.dart';
import 'package:flutter_app/features/song/domain/usecases/upload_song.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'song_event.dart';
part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final UploadSong _uploadSong;
  final GetAllSongs _getAllSongs;
  SongBloc({
    required UploadSong uploadSong,
    required GetAllSongs getAllSongs,
  })  : _uploadSong = uploadSong,
        _getAllSongs = getAllSongs,
        super(SongInitial()) {
    on<SongEvent>((event, emit) => emit(SongLoading()));
    on<SongUpload>(_onSongUpload);
    on<SongFetchAllSongs>(_onFetchAllSongs);
  }

  void _onSongUpload(
    SongUpload event,
    Emitter<SongState> emit,
  ) async {
    final res = await _uploadSong(
      UploadSongParams(
        user_id: event.user_id,
        title: event.title,
        author: event.author,
        image: event.image,
        mp3: event.mp3,
        language: event.language,
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
}