import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_play/features/home/presentation/bloc/home_bloc.dart';
import 'package:music_play/features/home/presentation/screen/home_screen.dart';
import 'package:music_play/locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white60,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.brown[400],
        scaffoldBackgroundColor: const Color.fromARGB(255, 250, 238, 222),
      ),
      debugShowCheckedModeBanner: false,
      title: "Music Player",
      home: BlocProvider(
        create: (context) => HomeBloc(),
        child: const HomeScreen(),
      ),
    );
  }
}
