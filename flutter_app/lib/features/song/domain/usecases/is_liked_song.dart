import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/core/usecase/usecase.dart';
import 'package:flutter_app/features/song/domain/repositories/song_repository.dart';
import 'package:fpdart/fpdart.dart';

class IsLikedSongParams {
  final int songId;
  IsLikedSongParams({required this.songId});
}

class IsLikedSong implements UseCase<bool, IsLikedSongParams> {
  final SongRepository songRepository;
  IsLikedSong(this.songRepository);

  @override
  Future<Either<Failure, bool>> call(IsLikedSongParams params) async {
    return await songRepository.isSongLiked(params.songId);
  }
}
