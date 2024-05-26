import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/common/widgets/loader.dart';
import 'package:flutter_app/core/utils/show_snackbar.dart';
import 'package:flutter_app/features/song/presentation/bloc/song_bloc.dart';
import 'package:flutter_app/features/song/presentation/pages/upload_new_song_page.dart';
import 'package:flutter_app/core/theme/app_palette.dart';
import 'package:flutter_app/features/song/presentation/widgets/liked_songs_button.dart';
import 'package:flutter_app/features/player/presentation/widget/player.dart';
import 'package:flutter_app/features/song/presentation/widgets/song_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    super.initState();
    context.read<SongBloc>().add(SongFetchAllSongs());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const Player(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocConsumer<SongBloc, SongState>(
        listener: (context, state) {
          if (state is SongFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is SongLoading) {
            return const Loader();
          }
          if (state is SongsDisplaySuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          GradientText(
                            'Good morning',
                            style: const TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                            ),
                            colors: const [
                              AppPallete.gradient1,
                              AppPallete.gradient2,
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.push(context, UploadNewSongPage.route());
                            },
                            icon: const Icon(
                              CupertinoIcons.add_circled,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      const LikedSongsButton(),
                      const SizedBox(height: 16.0),
                      const Text(
                        "Newest songs",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: state.songs.map((song) => Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: SongCard(song: song),
                    )).toList(),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
