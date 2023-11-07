import 'package:flutter/material.dart';
import 'package:fluttest/colors.dart';

final myTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: kGreen),
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: kGreen,
    iconTheme: IconThemeData(color: Colors.white),
  ),
);
