import 'package:flutter/material.dart';
import 'package:licencjat/Pages/HomePage.dart';
import 'package:licencjat/src/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
                brightness: Brightness.dark,
              )
                  : ThemeData(
                  brightness: Brightness.light,
              ),
              home: HomePage(),
              routes: {
              },
            );
          }),
    );
  }
}