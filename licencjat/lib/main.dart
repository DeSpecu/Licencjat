import 'package:flutter/material.dart';
import 'package:licencjat/Pages/HomePage.dart';
import 'package:licencjat/model/theme.dart';
import 'package:provider/provider.dart';
import './Pages/OfertyPage.dart';
import './Pages/ProfilPage.dart';
import './Pages/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
          builder: (context, ModelTheme themeNotifier, child) {
            return MaterialApp(
              theme: themeNotifier.isDark
                  ? ThemeData(
                scaffoldBackgroundColor: const Color.fromARGB(255, 93, 79, 74),
                cardTheme: CardTheme(color: Color.fromARGB(255, 93, 79, 74), ),
                appBarTheme: AppBarTheme(backgroundColor: Color.fromARGB(255, 93, 79, 74)),
                brightness: Brightness.dark,
              )
                  : ThemeData(
                  scaffoldBackgroundColor: const Color.fromARGB(255,255,255,255),
                  cardTheme: CardTheme(color: Color.fromARGB(255,255,255,255)),
                  brightness: Brightness.light,
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Color.fromARGB(255,255,255,255),
                  selectedItemColor: Color.fromARGB(255, 0, 0, 0)),
                  appBarTheme: AppBarTheme(backgroundColor: Color.fromARGB(0,0,0,255)),
              ),
              home: HomePage(),
              routes: {
                "/homepage": (context) => HomePage(),
                "/oferty": (context) => OfertyPage(),
                "/profil" : (context) => const ProfilPage()
              },
            );
          }),
    );
  }
}