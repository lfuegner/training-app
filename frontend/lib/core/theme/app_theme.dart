import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Provides light and dark [ThemeData] for the XTraining app.
class AppTheme {
  const AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.seedColor,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.headerDarkGreen,
          foregroundColor: AppColors.headerWhite,
          iconTheme: IconThemeData(color: AppColors.headerWhite),
          titleTextStyle: TextStyle(
            color: AppColors.headerWhite,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 4,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.seedColor,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.headerDarkGreen,
          foregroundColor: AppColors.headerWhite,
          iconTheme: IconThemeData(color: AppColors.headerWhite),
          titleTextStyle: TextStyle(
            color: AppColors.headerWhite,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 4,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
        ),
      );
}
