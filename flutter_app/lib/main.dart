import 'package:flutter/material.dart';
import 'package:flutter_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_app/core/network/connection_checker.dart';
import 'package:flutter_app/core/theme/theme.dart';
import 'package:flutter_app/features/song/presentation/bloc/song_bloc.dart';
import 'package:flutter_app/features/song/presentation/pages/home/home_page.dart';
import 'package:flutter_app/features/song/presentation/pages/liked/liked_page.dart';
import 'package:flutter_app/init_dependencies.dart';
import 'package:flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_app/features/auth/presentation/pages/LogIn/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<SongBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isConnected = true;
  bool isInitialized = false;
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final connectionChecker = serviceLocator<ConnectionChecker>();
    isConnected = await connectionChecker.isConnected;

    setState(() {
      isInitialized = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      // Afficher un écran de chargement pendant l'initialisation
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dj Pinguin',
        theme: AppTheme.darkThemeMode,
        home: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dj Pinguin',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return isConnected ? const HomePage() : const LikedPage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
