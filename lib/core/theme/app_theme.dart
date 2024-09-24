import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luit_dealer/core/theme/app_colors.dart';

customLightTheme() => ThemeData(
      splashColor: AppColors.whiteColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      useMaterial3: true,
      dividerTheme: DividerThemeData(space: 5),
      cardTheme: CardTheme(
        color: AppColors.whiteColor,
        elevation: 1,
      ),
      dividerColor: AppColors.greyColor,
      scaffoldBackgroundColor: AppColors.whiteColor,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        titleTextStyle: TextStyle(color: AppColors.whiteColor, fontSize: 28),
        backgroundColor: AppColors.primaryColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.whiteColor,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        unselectedItemColor: AppColors.black54Color,
        selectedItemColor: AppColors.primaryColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(width: 2, color: AppColors.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(width: 2, color: AppColors.errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(width: 2, color: AppColors.errorColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(width: 2, color: AppColors.black54Color),
        ),
      ),
    );
