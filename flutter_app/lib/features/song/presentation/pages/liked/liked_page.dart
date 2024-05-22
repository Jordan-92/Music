import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_palette.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LikedPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LikedPage(),
      );
  const LikedPage({Key? key}) : super(key: key);

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  List<String> selectedLanguages = [];

  @override
  Widget build(BuildContext context) {
    final List<String> languages = [
      'English',
      'Spanish',
      'French',
      'Others',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/liked.png',
              height: 60.0,
              width: 60.0,
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
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
                      setState(() {});
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
      ),
    );
  }
}
