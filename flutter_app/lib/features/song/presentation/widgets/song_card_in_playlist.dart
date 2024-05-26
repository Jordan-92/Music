import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_palette.dart';
import 'package:flutter_app/features/song/domain/entities/song.dart';

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
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width - 16.0; // 16.0 for padding

    return GestureDetector(
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
              child: Image.asset(
              'assets/liked.png',
                height: 50.0,
                width: 50.0,
                fit: BoxFit.cover,
              ),
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
              onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
