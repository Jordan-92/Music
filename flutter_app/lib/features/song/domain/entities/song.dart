// import 'package:audio_service/audio_service.dart';

import 'dart:typed_data';

class Song {
  final int? id;
  final String user_id;
  // final String albumId,
  final String author;
  final String title;
  final String song_path;
  final String image_path;
  final String language;
  final Duration duration;
  final Uint8List? imageData;

  Song({
    this.id,
    required this.user_id,
    // final String albumId,
    required this.author,
    required this.title,
    required this.song_path,
    required this.image_path,
    required this.language,
    required this.duration,
    this.imageData,
  });
}
