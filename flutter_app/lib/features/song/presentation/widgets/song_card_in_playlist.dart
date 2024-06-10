import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/core/theme/app_palette.dart';
import 'package:flutter_app/features/song/domain/entities/song.dart';
import 'package:flutter_app/features/song/presentation/bloc/song_bloc.dart';

class SongCardInPlaylist extends StatefulWidget {
  final Song song;

  const SongCardInPlaylist({
    super.key,
    required this.song,
  });

  @override
  _SongCardInPlaylistState createState() => _SongCardInPlaylistState();
}

class _SongCardInPlaylistState extends State<SongCardInPlaylist> {
  bool isLiked = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkIfLiked();
  }

  void _checkIfLiked() {
    final songId = widget.song.id;
    if (songId != null) {
      // Appeler le BLoC de manière asynchrone après le rendu du cadre actuel
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<SongBloc>().add(SongIsLiked(songId: songId));
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: Song ID is null')),
        );
      });
    }
  }

  void _toggleLike() {
    final songId = widget.song.id;
    if (songId != null) {
      if (isLiked) {
        context.read<SongBloc>().add(SongDislike(songId: songId));
      } else {
        context.read<SongBloc>().add(SongLike(songId: songId));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: Song ID is null')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width - 16.0;

    return BlocListener<SongBloc, SongState>(
      listener: (context, state) {
        if (state is SongIsLikedSuccess) {
          setState(() {
            isLiked = state.isLiked;
          });
        } else if (state is SongLikeSuccess) {
          setState(() {
            isLiked = true;
          });
        } else if (state is SongDislikeSuccess) {
          setState(() {
            isLiked = false;
          });
        // } else if (state is SongFailure) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text(state.message)),
        //   );
        }
      },
      child: GestureDetector(
        onTap: () {
          // TODO: context.read<AudioPlayerBloc>().add(SetAudioEvent(song: song));
        },
        child: Container(
          width: cardWidth,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppColors.fixedBrightened,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: _buildSongImage(widget.song.imageData),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.song.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'By ${widget.song.author}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.grey,
                ),
                onPressed: _toggleLike,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSongImage(Uint8List? imageData) {
    if (imageData != null) {
      return Image.memory(
        imageData,
        height: 50.0,
        width: 50.0,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'assets/liked.png',
        height: 50.0,
        width: 50.0,
        fit: BoxFit.cover,
      );
    }
  }
}
