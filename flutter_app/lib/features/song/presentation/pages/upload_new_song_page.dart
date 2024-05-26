import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_app/core/common/widgets/loader.dart';
import 'package:flutter_app/core/theme/app_palette.dart';
import 'package:flutter_app/core/utils/pick_image.dart';
import 'package:flutter_app/core/utils/show_snackbar.dart';
import 'package:flutter_app/features/song/presentation/bloc/song_bloc.dart';
import 'package:flutter_app/features/song/presentation/pages/home_page.dart';
import 'package:flutter_app/features/song/presentation/widgets/song_editor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:file_picker/file_picker.dart';

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
  final languageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? image;
  File? audioFile;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void selectAudio() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        audioFile = File(result.files.single.path!);
      });
    }
  }

  void uploadSong() {
    if (formKey.currentState!.validate() &&
        image != null &&
        audioFile != null) {
      final userid =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<SongBloc>().add(
            SongUpload(
              user_id: userid,
              title: titleController.text.trim(),
              author: authorController.text.trim(),
              image: image!,
              mp3: audioFile!,
              language: languageController.text.trim(),
            ),
          );
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    authorController.dispose();
    languageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText(
          'Upload a new song',
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
              uploadSong();
            },
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: BlocConsumer<SongBloc, SongState>(
        listener: (context, state) {
          if (state is SongFailure) {
            showSnackBar(context, state.error);
          } else if (state is SongUploadSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              HomePage.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if(state is SongLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
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
                  GestureDetector(
                    onTap: selectAudio,
                    child: DottedBorder(
                      color: AppPallete.borderColor,
                      dashPattern: const [10, 4],
                      radius: const Radius.circular(10),
                      borderType: BorderType.RRect,
                      strokeCap: StrokeCap.round,
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        child: Center(
                          child: audioFile != null
                              ? Text(
                                  'Selected: ${audioFile!.path.split('/').last}',
                                  style: const TextStyle(fontSize: 15),
                                )
                              : const Text(
                                  'Select an audio file',
                                  style: TextStyle(fontSize: 15),
                                ),
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
                  const SizedBox(height: 10),
                  SongEditor(
                    controller: languageController,
                    hintText: 'Language',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
