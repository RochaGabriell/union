/* Flutter Imports */
import 'package:flutter/material.dart';

/* Project Imports */
import 'package:union/core/themes/palette.dart';

class CustomTheme {
  static final light = ThemeData.light().copyWith(
    // primaryColor
    primaryColor: Palette.primary,
    // scaffoldBackgroundColor
    scaffoldBackgroundColor: Palette.background,
    // appBarTheme
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0.0,
      backgroundColor: Palette.background,
      foregroundColor: Palette.primary,
      iconTheme: IconThemeData(color: Palette.primary, size: 24),
      titleTextStyle: TextStyle(
        color: Palette.primary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
    ),
    // ProgressIndicatorTheme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Palette.primary,
      refreshBackgroundColor: Palette.background,
      circularTrackColor: Palette.background,
    ),
    // DialogTheme
    dialogTheme: DialogTheme(
      alignment: Alignment.center,
      backgroundColor: Palette.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titleTextStyle: const TextStyle(
        color: Palette.textColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: const TextStyle(color: Palette.textColor, fontSize: 18),
    ),
    // ChoiceChipTheme
    chipTheme: const ChipThemeData(
      showCheckmark: false,
      selectedColor: Palette.primary,
      backgroundColor: Palette.secondaryDark,
      secondarySelectedColor: Palette.primary,
      labelStyle: TextStyle(
        fontSize: 18,
        color: Palette.primary,
        fontWeight: FontWeight.bold,
      ),
      secondaryLabelStyle: TextStyle(color: Palette.secondary),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: Palette.transparent),
      ),
    ),
    // ListTileTheme
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: Palette.background,
      iconColor: Palette.textColor,
      titleTextStyle: const TextStyle(
        color: Palette.textColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      subtitleTextStyle: const TextStyle(
        color: Palette.textDescriptionColor,
        fontSize: 16,
      ),
    ),
    // ExpansionTileTheme
    expansionTileTheme: ExpansionTileThemeData(
      iconColor: Palette.textColor,
      textColor: Palette.textColor,
      collapsedIconColor: Palette.textColor,
      collapsedTextColor: Palette.textColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Palette.divider, width: 1),
      ),
    ),
    // FloatingActionButtonThemeData
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Palette.primary,
      foregroundColor: Palette.white,
    ),
    // NavigationBarTheme
    navigationBarTheme: NavigationBarThemeData(
      height: 80,
      elevation: 0,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      indicatorColor: Palette.transparent,
      labelTextStyle: const WidgetStatePropertyAll(
        TextStyle(
          color: Palette.primary,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: const WidgetStatePropertyAll(
        IconThemeData(color: Palette.primary, size: 24),
      ),
      backgroundColor: Palette.white,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    ),
    // textTheme
    textTheme: const TextTheme(
      // title
      titleLarge: TextStyle(color: Palette.textColor, fontSize: 34),
      titleMedium: TextStyle(color: Palette.textColor, fontSize: 22),
      titleSmall: TextStyle(color: Palette.textColor, fontSize: 20),
      // label
      labelLarge: TextStyle(color: Palette.textLinkColor, fontSize: 20),
      labelMedium: TextStyle(color: Palette.textLinkColor, fontSize: 18),
      labelSmall: TextStyle(color: Palette.textLinkColor, fontSize: 16),
      // body
      bodyLarge: TextStyle(color: Palette.textColor, fontSize: 18),
      bodyMedium: TextStyle(color: Palette.textColor, fontSize: 16),
      bodySmall: TextStyle(color: Palette.textColor, fontSize: 14),
    ),
    // buttonTheme
    buttonTheme: ButtonThemeData(
      buttonColor: Palette.primary,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    // ElevatedButtonThemeData
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.primary,
        foregroundColor: Palette.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    // inputDecorationTheme
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: Palette.textDescriptionColor,
      contentPadding: const EdgeInsets.all(16),
      focusedBorder: _border(Palette.primary),
      enabledBorder: _border(),
      errorBorder: _border(Palette.error),
      focusedErrorBorder: _border(Palette.error),
      disabledBorder: _border(Palette.disabled),
      border: _border(),
      labelStyle: const TextStyle(color: Palette.textDescriptionColor),
      hintStyle: const TextStyle(color: Palette.textDescriptionColor),
    ),
    // DividerThemeData
    dividerTheme: const DividerThemeData(color: Palette.divider),
  );

  static final dark = ThemeData.dark().copyWith(
    // primaryColor
    primaryColor: Palette.primaryDark,
    // scaffoldBackgroundColor
    scaffoldBackgroundColor: Palette.backgroundDark,
    // appBarTheme
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0.0,
      backgroundColor: Palette.backgroundDark,
      foregroundColor: Palette.primaryDark,
      iconTheme: IconThemeData(color: Palette.primaryDark, size: 24),
      titleTextStyle: TextStyle(
        color: Palette.primary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
    ),
    // ProgressIndicatorTheme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Palette.primaryDark,
      refreshBackgroundColor: Palette.backgroundDark,
      circularTrackColor: Palette.backgroundDark,
    ),
    // DialogTheme
    dialogTheme: DialogTheme(
      alignment: Alignment.center,
      backgroundColor: Palette.backgroundDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titleTextStyle: const TextStyle(
        color: Palette.textDarkColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: const TextStyle(
        color: Palette.textDarkColor,
        fontSize: 18,
      ),
    ),
    // ChoiceChipTheme
    chipTheme: const ChipThemeData(
      showCheckmark: false,
      selectedColor: Palette.primaryDark,
      backgroundColor: Palette.secondaryDark,
      secondarySelectedColor: Palette.primaryDark,
      labelStyle: TextStyle(
        fontSize: 18,
        color: Palette.primaryDark,
        fontWeight: FontWeight.bold,
      ),
      secondaryLabelStyle: TextStyle(color: Palette.secondary),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: Palette.transparent),
      ),
    ),
    // ListTileTheme
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: Palette.backgroundDark,
      iconColor: Palette.textDarkColor,
      titleTextStyle: const TextStyle(
        color: Palette.textDarkColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      subtitleTextStyle: const TextStyle(
        color: Palette.textDescriptionColor,
        fontSize: 16,
      ),
    ),
    // ExpansionTileTheme
    expansionTileTheme: ExpansionTileThemeData(
      iconColor: Palette.textDarkColor,
      textColor: Palette.textDarkColor,
      collapsedIconColor: Palette.textDarkColor,
      collapsedTextColor: Palette.textDarkColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Palette.disabled, width: 1),
      ),
    ),
    // FloatingActionButtonThemeData
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Palette.primaryDark,
      foregroundColor: Palette.white,
    ),
    // NavigationBarTheme
    navigationBarTheme: NavigationBarThemeData(
      height: 80,
      elevation: 0,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      indicatorColor: Palette.transparent,
      labelTextStyle: const WidgetStatePropertyAll(
        TextStyle(
          color: Palette.primaryDark,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: const WidgetStatePropertyAll(
        IconThemeData(color: Palette.primaryDark, size: 24),
      ),
      backgroundColor: Palette.black,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    ),
    // textTheme
    textTheme: const TextTheme(
      // title
      titleLarge: TextStyle(color: Palette.textDarkColor, fontSize: 34),
      titleMedium: TextStyle(color: Palette.textDarkColor, fontSize: 22),
      titleSmall: TextStyle(color: Palette.textDarkColor, fontSize: 20),
      // label
      labelLarge: TextStyle(color: Palette.textLinkColor, fontSize: 20),
      labelMedium: TextStyle(color: Palette.textLinkColor, fontSize: 18),
      labelSmall: TextStyle(color: Palette.textLinkColor, fontSize: 16),
      // body
      bodyLarge: TextStyle(color: Palette.textDarkColor, fontSize: 18),
      bodyMedium: TextStyle(color: Palette.textDarkColor, fontSize: 16),
      bodySmall: TextStyle(color: Palette.textDarkColor, fontSize: 14),
    ),
    // TextFormTheme
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: Palette.textDescriptionColor,
      contentPadding: const EdgeInsets.all(16),
      focusedBorder: _border(Palette.primaryDark),
      enabledBorder: _border(),
      errorBorder: _border(Palette.error),
      focusedErrorBorder: _border(Palette.error),
      disabledBorder: _border(Palette.disabled),
      border: _border(),
      labelStyle: const TextStyle(color: Palette.textDescriptionColor),
      hintStyle: const TextStyle(color: Palette.textDescriptionColor),
    ),
    // buttonTheme
    buttonTheme: ButtonThemeData(
      buttonColor: Palette.primaryDark,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    // ElevatedButtonThemeData
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.primaryDark,
        foregroundColor: Palette.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );

  static _border([Color color = Palette.border]) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
