import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/core/theme/app_palette.dart';
import 'package:flutter_app/core/utils/pick_image.dart';
import 'package:flutter_app/features/music/presentation/widgets/song_editor.dart';

class UploadNewSongPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const UploadNewSongPage(),
      );
  const UploadNewSongPage({super.key});

  @override
  State<UploadNewSongPage> createState() => _UploadNewSongPageState();
}

class _UploadNewSongPageState extends State<UploadNewSongPage> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    authorController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            image != null
                ? GestureDetector(
                    onTap: selectImage,
                    child: SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      selectImage();
                    },
                    child: DottedBorder(
                      color: AppPallete.borderColor,
                      dashPattern: const [10, 4],
                      radius: const Radius.circular(10),
                      borderType: BorderType.RRect,
                      strokeCap: StrokeCap.round,
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.folder_open,
                              size: 40,
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Select an image',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 10),
            SongEditor(
              controller: titleController,
              hintText: 'Title',
            ),
            const SizedBox(height: 10),
            SongEditor(
              controller: authorController,
              hintText: 'Author',
            ),
          ],
        ),
      ),
    );
  }
}
