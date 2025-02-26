import 'package:flutter/material.dart';
import 'color.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.background, // Light Cream background
  primaryColor: AppColors.primary, // Soft Green
  hintColor: AppColors.accent, // Bright Yellow accents

  textTheme: TextTheme(
    bodyLarge: TextStyle(color: AppColors.text, fontSize: 18),
    bodyMedium: TextStyle(color: AppColors.text200, fontSize: 16),
    titleLarge: TextStyle(color: AppColors.textAlt, fontSize: 20, fontWeight: FontWeight.bold),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.appBarColor, // Dark Blue-Grey AppBar
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.white), // White icons
    elevation: 4,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: AppColors.selectedNavColor, // Dark Green
    unselectedItemColor: AppColors.unselectedNavColor, // Light Gray
    selectedIconTheme: IconThemeData(size: 28),
    unselectedIconTheme: IconThemeData(size: 24),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary, // Soft Green buttons
      foregroundColor: Colors.white, // White text
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.accent, // Bright Yellow Floating Button
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.bg200, // Light background
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.primary200),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary200, width: 1),
    ),
    labelStyle: TextStyle(color: AppColors.text),
    hintStyle: TextStyle(color: AppColors.text200),
  ),

  tabBarTheme: TabBarTheme(
    labelColor: Colors.white,
    unselectedLabelColor: AppColors.bg300,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.accent,
    ),
  ),

  dialogTheme: DialogTheme(
    backgroundColor: AppColors.background,
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.text),
    contentTextStyle: TextStyle(fontSize: 16, color: AppColors.text200),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  ),

  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(Colors.white),
    fillColor: MaterialStateProperty.all(AppColors.primary),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  ),

  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all(AppColors.primary200),
    thumbColor: MaterialStateProperty.all(AppColors.primary),
  ),

  dividerTheme: DividerThemeData(
    color: AppColors.primary200,
    thickness: 1,
  ),
);
