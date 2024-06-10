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

class SongFetchAllSongs extends SongEvent {}

class SongFetchLikedSongs extends SongEvent {}

class SongLike extends SongEvent {
  final int songId;

  SongLike({required this.songId});
}

class SongDislike extends SongEvent {
  final int songId;

  SongDislike({required this.songId});
}

class SongIsLiked extends SongEvent {
  final int songId;

  SongIsLiked({required this.songId});
}