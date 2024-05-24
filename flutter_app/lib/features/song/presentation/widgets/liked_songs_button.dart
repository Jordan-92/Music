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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
            ),
            child: Image.asset(
              'assets/liked.png',
              height: 60.0,
              width: 60.0,
            ),
          ),
          
          const SizedBox(width: 16.0),
          const Text(
            'Liked songs',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
