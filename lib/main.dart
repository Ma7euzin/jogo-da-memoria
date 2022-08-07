import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:memoria/repositories/recordes_repository.dart';
import 'package:memoria/splash_screen/splash_screen.dart';
import 'package:memoria/theme.dart';
import 'package:provider/provider.dart';

import 'controllers/game_controller.dart';

void main() async {
  await Hive.initFlutter();

  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  runApp(MultiProvider(
    providers: [
      Provider<RecordesRepository>(create: (_) => RecordesRepository()),
      ProxyProvider<RecordesRepository, GameController>(
        update: (_, repo, __) => GameController(recordesRepository: repo),
      ),
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Memoria',
      debugShowCheckedModeBanner: false,
      theme: NarutoTheme.theme,
      home: const SplashScreen(),
    );
  }
}
