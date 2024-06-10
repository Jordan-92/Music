import 'dart:typed_data';

import 'package:flutter_app/features/song/domain/entities/song.dart';

class SongModel extends Song {
  final int? id;
  final Uint8List? imageData;

  SongModel({
    this.id,
    required super.user_id,
    required super.author,
    required super.title,
    required super.song_path,
    required super.image_path,
    required super.language,
    required super.duration,
    this.imageData,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'user_id': user_id,
      'author': author,
      'title': title,
      'song_path': song_path,
      'image_path': image_path,
      'language': language,
      'duration': duration.inSeconds,
    };

    if (id != null) {
      data['id'] = id;
    }

    if (imageData != null) {
      data['imageData'] = imageData;
    }

    return data;
  }

  factory SongModel.fromJson(Map<String, dynamic> map) {
    return SongModel(
      id: map['id'] as int,
      user_id: map['user_id'] as String,
      author: map['author'] as String,
      title: map['title'] as String,
      song_path: map['song_path'] as String,
      image_path: map['image_path'] as String,
      language: map['language'] as String,
      duration: Duration(seconds: map['duration']),
      imageData: map['imageData'] != null ? Uint8List.fromList(List<int>.from(map['imageData'])) : null,
    );
  }

  SongModel copyWith({
    int? id,
    String? user_id,
    String? author,
    String? title,
    String? song_path,
    String? image_path,
    String? language,
    Duration? duration,
    Uint8List? imageData,
  }) {
    return SongModel(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      author: author ?? this.author,
      title: title ?? this.title,
      song_path: song_path ?? this.song_path,
      image_path: image_path ?? this.image_path,
      language: language ?? this.language,
      duration: duration ?? this.duration,
      imageData: imageData ?? this.imageData,
    );
  }
}
