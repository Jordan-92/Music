// import 'package:audio_service/audio_service.dart';

class Song {
  final String user_id;
  // final String albumId,
  final String author;
  final String title;
  final String song_path;
  final String image_path;
  final String language;
  final Duration duration;

  Song({
    required this.user_id,
    // final String albumId,
    required this.author,
    required this.title,
    required this.song_path,
    required this.image_path,
    required this.language,
    required this.duration,
  });

//   factory Song.fromMediaItem(MediaItem mediaItem) {
//     try {
//       return Song(
//         user_id: mediaItem.id,
//         // albumId: mediaItem.album ?? '',
//         author: mediaItem.artist ?? '',
//         title: mediaItem.title,
//         language: '',
//         song_path: mediaItem.extras!['audioUrl'],
//         image_path: mediaItem.extras!['imageUrl'] ?? 0,
//         duration: mediaItem.duration ?? Duration.zero,
//       );
//     } catch (err) {
//       throw Exception('Failed to convert MediaItem to Song: $err');
//     }
//   }

//   MediaItem toMediaItem() => MediaItem(
//         id: user_id,
//         // album: albumId,
//         artist: author,
//         title: title,
//         extras: <String, dynamic>{
//           'audioUrl': song_path,
//           'imageUrl': image_path,
//         },
//       );
}
