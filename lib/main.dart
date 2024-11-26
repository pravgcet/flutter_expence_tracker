import 'package:flutter/material.dart';
import 'package:flutter_expence_tracker/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(1, 52, 224, 90),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(1, 4, 30, 180),
);

void main() {
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //    .then((fn) {
  runApp(const MyApp());
  //});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(colorScheme: kDarkColorScheme),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer),
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 16),
            ),
      ),
      themeMode: ThemeMode.system,
      home: Expenses(),
      debugShowCheckedModeBanner: false,
    );
  }
}
