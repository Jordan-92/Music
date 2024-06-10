import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants/constants.dart';
import 'package:flutter_app/features/song/domain/entities/song.dart';
import 'package:flutter_app/features/song/presentation/widgets/song_card_in_playlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/core/common/widgets/loader.dart';
import 'package:flutter_app/core/network/connection_checker.dart';
import 'package:flutter_app/core/theme/app_palette.dart';
import 'package:flutter_app/core/utils/show_snackbar.dart';
import 'package:flutter_app/features/player/presentation/widget/player.dart';
import 'package:flutter_app/features/song/presentation/bloc/song_bloc.dart';
import 'package:flutter_app/features/song/presentation/pages/home_page.dart';
import 'package:flutter_app/init_dependencies.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LikedPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LikedPage(),
      );
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  List<String> selectedLanguages = [];
  List<Song> filteredSongs = [];

  @override
  void initState() {
    super.initState();
    context.read<SongBloc>().add(SongFetchLikedSongs());
  }

  Future<void> _handleHomeButton() async {
    final connectionChecker = serviceLocator<ConnectionChecker>();
    final isConnected = await connectionChecker.isConnected;

    if (isConnected) {
      Navigator.push(context, HomePage.route());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(Constants.noConnectionErrorMessage),
        ),
      );
    }
  }

  void _filterSongs(List<Song> songs) {
    setState(() {
      if (selectedLanguages.isEmpty) {
        filteredSongs = songs;
      } else {
        filteredSongs = songs.where((song) {
          if (selectedLanguages.contains('Others')) {
            return selectedLanguages.contains(song.language) ||
                !['English', 'Spanish', 'French'].contains(song.language);
          }
          return selectedLanguages.contains(song.language);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> languages = [
      'English',
      'Spanish',
      'French',
      'Others',
    ];

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
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (filteredSongs.isEmpty) {
                _filterSongs(state.songs);
              }
            });
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.home),
                        onPressed: _handleHomeButton,
                      ),
                      const SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/liked.png',
                          height: 50.0,
                          width: 50.0,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      GradientText(
                        'Liked Songs',
                        style: const TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                        colors: const [
                          AppPallete.gradient1,
                          AppPallete.gradient2,
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search by title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      contentPadding: const EdgeInsets.all(0),
                      fillColor: AppColors.fixedBrightened,
                    ),
                    onChanged: (value) {
                      //TODO: search logic here
                    },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: languages.map((String language) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedLanguages.contains(language)) {
                                  selectedLanguages.remove(language);
                                } else {
                                  selectedLanguages.add(language);
                                }
                              });
                              _filterSongs(state.songs);
                            },
                            child: Chip(
                              label: Text(language),
                              color: selectedLanguages.contains(language)
                                  ? const MaterialStatePropertyAll(AppPallete.gradient1)
                                  : null,
                              side: selectedLanguages.contains(language) ? null : const BorderSide(
                                color: AppPallete.borderColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 100, left: 8, right: 8),
                        child: Column(
                          children: filteredSongs.map((song) => SongCardInPlaylist(song: song),
                          ).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
