import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; // Access system services
import 'package:expense_tracker/widgets/expense_tracker.dart';

void main() {
  // lock the System Orientation to Portrait
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn) {}

  // Run the app when Portrait theme is locked for the app
  runApp(const MyApp());
}

var kColorAccent = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
var kColorDarkAccent = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Adding useMaterial3: true line to make the app user Material 3
      // Color Scheme with fromSeed is used to make a Seed Purple color and set diff
      // accents of same on diff screens
      title: 'Expense Manger',
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kColorDarkAccent,
        useMaterial3: true,
        cardTheme: const CardTheme().copyWith(
          color: kColorDarkAccent.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          elevation: 16,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorDarkAccent.primaryContainer,
            foregroundColor: kColorDarkAccent.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorAccent,
        useMaterial3: true,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorAccent.onPrimaryContainer,
          foregroundColor: kColorAccent.onPrimary,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorAccent.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          elevation: 16,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorAccent.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
      ),
      themeMode: ThemeMode.system,
      home: const ExpenseTracker(),
    );
  }
}
