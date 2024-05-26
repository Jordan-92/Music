import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_palette.dart';
import 'package:flutter_app/features/song/domain/entities/song.dart';

class SongCard extends StatelessWidget {
  final Song song;
  const SongCard({
    super.key,
    required this.song,
  });

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width / 3;
    final double cardHeight = cardWidth * 1.5;

    return GestureDetector(
      onTap: () {
        //TODO: context.read<AudioPlayerBloc>().add(SetAudioEvent(song: song));
      },
      child: Container(
        width: cardWidth,
        height: cardHeight,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppColors.fixedBrightened,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  song.image_path
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              song.title,
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
              'By ${song.author}',
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
    );
  }
}
