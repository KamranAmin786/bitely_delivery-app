import 'package:flutter/material.dart';

import 'data/cart.dart';
import 'screens/home_screen.dart';
import 'theme.dart';

void main() => runApp(const BitelyApp());

class BitelyApp extends StatefulWidget {
  const BitelyApp({super.key});

  @override
  State<BitelyApp> createState() => _BitelyAppState();
}

class _BitelyAppState extends State<BitelyApp> {
  final _cart = Cart();

  @override
  Widget build(BuildContext context) {
    return CartScope(
      cart: _cart,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
