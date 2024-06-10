import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/core/usecase/usecase.dart';
import 'package:flutter_app/features/song/domain/repositories/song_repository.dart';
import 'package:fpdart/fpdart.dart';

class LikeSongParams {
  final int songId; // Modifiez le type de songId en int
  LikeSongParams({required this.songId});
}

class LikeSong implements UseCase<void, LikeSongParams> {
  final SongRepository songRepository;
  LikeSong(this.songRepository);

  @override
  Future<Either<Failure, void>> call(LikeSongParams params) async {
    return await songRepository.likeSong(params.songId);
  }
}
