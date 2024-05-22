import 'package:flutter/material.dart';
import 'package:flutter_app/features/song/presentation/pages/liked/liked_page.dart';

class LikedSongsButton extends StatelessWidget {
  const LikedSongsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, LikedPage.route());
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 60.0,
            height: 60.0,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: AssetImage('assets/liked.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          const Text(
            'Liked songs',
            style: TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}
