import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/music/presentation/pages/upload/upload_new_song_page.dart';

import 'package:flutter_app/core/theme/app_palette.dart';
import 'package:flutter_app/features/music/presentation/widgets/liked_songs_button.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

part 'widgets/_home_app_bar.dart';
part 'widgets/_home_tab_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText(
          'Good morning', 
          style: const TextStyle(
              fontSize: 30.0,
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
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            LikedSongsButton(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
