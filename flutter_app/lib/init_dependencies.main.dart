part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initSong();
  // _initPlayer();

  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerLazySingleton(
    () => Hive.box(name: 'songs'),
  );

  serviceLocator.registerFactory(() => InternetConnection());

  // core
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
}

void _initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initSong() {
  // Datasource
  serviceLocator
    ..registerFactory<SongRemoteDataSource>(
      () => SongRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<SongLocalDataSource>(
      () => SongLocalDataSourceImpl(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<SongRepository>(
      () => SongRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => UploadSong(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllSongs(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetLikedSongs(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => LikeSong(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => DislikeSong(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => IsLikedSong(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => SongBloc(
        uploadSong: serviceLocator(),
        getAllSongs: serviceLocator(),
        getLikedSongs: serviceLocator(),
        likeSong: serviceLocator(),
        dislikeSong: serviceLocator(),
        isLikedSong: serviceLocator(),
      ),
    );
}

// void _initPlayer() {
//   // Bloc
//   serviceLocator.registerLazySingleton(
//     () => AudioPlayerBloc(
//       _onLoadAudioPlayer: serviceLocator(),
//       _onPlayAudio: serviceLocator(),
//       _onPauseAudio: serviceLocator(),
//       _onSetAudio: serviceLocator(),
//     ),
//   );
// }
