import 'package:flutter/material.dart';
import 'package:flutter_app/features/player/presentation/bloc/player_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Player extends StatelessWidget {
  const Player({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
    //   builder: (context, state) {
    //     if (state.status == AudioPlayerStatus.initial) {
    //       return const SizedBox();
    //     }
    //     if (state.audioPlayerData?.audio == null) {
    //       return const SizedBox();
    //     }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              height: kToolbarHeight,
              margin: const EdgeInsets.all(8.0).copyWith(bottom: 0.0),
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: colorScheme.surface,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.asset(
                      'assets/liked.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'title',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'artist',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyMedium!.copyWith(
                            color: colorScheme.onBackground.withOpacity(.75),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_left),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_right),
                  ),
                  const SizedBox(width: 8.0),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape: SliderComponentShape.noThumb,
                ),
                child: Slider(
                  min: 0.0,
                  max: 1000,
                  value: 200,
                  onChanged: (double value) {},
                ),
              ),
            )
          ],
        );
      // },
    // );
  }
}
