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
      theme: ThemeData(accentColor: Colors.tealAccent[700]),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        PairingScreen.id: (context) => PairingScreen(),
        InfoScreen.id: (context) => InfoScreen(),
      },
    );
  }
}
// command to connect to phone before running
// adb connect 192.168.10.14:5555
