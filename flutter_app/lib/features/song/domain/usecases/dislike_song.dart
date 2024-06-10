import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/core/usecase/usecase.dart';
import 'package:flutter_app/features/song/domain/repositories/song_repository.dart';
import 'package:fpdart/fpdart.dart';

class DislikeSongParams {
  final int songId;
  DislikeSongParams({required this.songId});
}

class DislikeSong implements UseCase<void, DislikeSongParams> {
  final SongRepository songRepository;
  DislikeSong(this.songRepository);

  @override
  Future<Either<Failure, void>> call(DislikeSongParams params) async {
    return await songRepository.dislikeSong(params.songId);
  }
}
