part of 'song_bloc.dart';

@immutable
sealed class SongEvent {}

final class SongUpload extends SongEvent {
  final String user_id;
  final String title;
  final String author;
  final File image;
  final File mp3;
  final String language;

  SongUpload({
    required this.user_id,
    required this.title,
    required this.author,
    required this.image,
    required this.mp3,
    required this.language,
  });
}

final class SongFetchAllSongs extends SongEvent {}