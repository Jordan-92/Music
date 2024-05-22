part of 'song_bloc.dart';

@immutable
sealed class SongState {}

final class SongInitial extends SongState {}

final class SongLoading extends SongState {}

final class SongFailure extends SongState {
  final String error;
  SongFailure(this.error);
}

final class SongUploadSuccess extends SongState {}

final class SongsDisplaySuccess extends SongState {
  final List<Song> songs;
  SongsDisplaySuccess(this.songs);
}