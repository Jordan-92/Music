import 'package:flutter/material.dart';
import 'package:flutter_app/core/network/connection_checker.dart';
import 'package:flutter_app/core/theme/app_palette.dart';
import 'package:flutter_app/features/song/presentation/pages/home/home_page.dart';
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

  Future<void> _handleHomeButton() async {
    final connectionChecker = serviceLocator<ConnectionChecker>();
    final isConnected = await connectionChecker.isConnected;

    if (isConnected) {
      Navigator.push(context, HomePage.route());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No internet connection. Please try again later.'),
        ),
      );
    }
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
      body: Padding(
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
          ],
        ),
      ),
    );
  }
}
