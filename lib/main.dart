import 'package:expense_tracker/Wigets/expenses.dart';

import 'package:flutter/material.dart';

var kcolorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 0, 78, 152),
);

var kcolordarkScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 0, 109, 119),
);
void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      //Dark
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kcolordarkScheme,
        cardTheme: const CardTheme().copyWith(
          color: kcolordarkScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kcolordarkScheme.primaryContainer,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: kcolordarkScheme.primaryContainer,
          foregroundColor: kcolordarkScheme.onPrimaryContainer,
        ),
      ),

      // light theme
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kcolorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kcolorScheme.onPrimaryContainer,
          foregroundColor: kcolorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kcolorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kcolorScheme.primaryContainer,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: kcolorScheme.onPrimaryContainer,
          foregroundColor: kcolorScheme.primaryContainer,
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontSize: 22,
                color: kcolorScheme.onSecondaryContainer,
                fontWeight: FontWeight.w400,
              ),
            ),
      ),
      themeMode: ThemeMode.system, // default,
      home: const Expenses(),
    ),
  );
  // });
}
