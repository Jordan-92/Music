import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/common/widgets/loader.dart';
import 'package:flutter_app/core/utils/show_snackbar.dart';
import 'package:flutter_app/features/song/presentation/bloc/song_bloc.dart';
import 'package:flutter_app/features/song/presentation/pages/upload/upload_new_song_page.dart';
import 'package:flutter_app/core/theme/app_palette.dart';
import 'package:flutter_app/features/song/presentation/widgets/liked_songs_button.dart';
import 'package:flutter_app/features/song/presentation/widgets/song_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

part 'widgets/_home_app_bar.dart';
part 'widgets/_home_tab_bar.dart';

class HomeScreen extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  
  @override
  void initState() {
    super.initState();
    context.read<SongBloc>().add(SongFetchAllSongs());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText(
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
        actions: [
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.0),
                      LikedSongsButton(),
                      SizedBox(height: 16.0),
                      Text(
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
