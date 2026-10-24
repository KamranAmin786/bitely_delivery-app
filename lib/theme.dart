import 'package:flutter/material.dart';

const orange = Color(0xFFFF6B35);
const cream = Color(0xFFFFF7F0);
const ink = Color(0xFF1E1E2A);
const grey = Color(0xFF9A98A6);

final appTheme = ThemeData(
  fontFamily: 'Inter',
  scaffoldBackgroundColor: cream,
  colorScheme: ColorScheme.fromSeed(seedColor: orange, primary: orange),
);
