import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_app/core/usecase/usecase.dart';
import 'package:flutter_app/features/song/domain/entities/song.dart';
import 'package:flutter_app/features/song/domain/repositories/song_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllSongs implements UseCase<List<Song>, NoParams> {
  final SongRepository songRepository;
  GetAllSongs(this.songRepository);

  @override
  Future<Either<Failure, List<Song>>> call(NoParams params) async {
    return await songRepository.getAllSongs();
  }
}