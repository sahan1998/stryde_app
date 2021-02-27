//.. Welcome screen that allows user to connect to navigate to BLE pairing screen ..//

import 'package:flutter/material.dart';
import 'package:stryde_app/components/rounded_button.dart';
import 'package:stryde_app/screens/pairing_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //..LOGO AND TITLE..//
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset('images/logo.png'),
                  height: 70.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Stryde',
                  style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      letterSpacing: 0.1),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            //..PAIRING BUTTON..//
            RoundedButton(
              title: 'Connect to Device',
              onPressed: () {
                Navigator.pushNamed(context, PairingScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
