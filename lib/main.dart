import 'package:flutter/material.dart';
import 'package:stryde_app/screens/information_screen.dart';
import 'package:stryde_app/screens/pairing_screen.dart';
import 'package:stryde_app/screens/welcome_screen.dart';

void main() {
  runApp(Stryde());
}

class Stryde extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        PairingScreen.id: (context) => PairingScreen(),
        InfoScreen.id: (context) => InfoScreen(),
      },
    );
  }
}
