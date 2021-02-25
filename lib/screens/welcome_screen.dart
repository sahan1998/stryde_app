import 'package:flutter/material.dart';
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
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Material(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(25.0),
                elevation: 3.0,
                child: MaterialButton(
                  child: Text(
                    'Connect to Device',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  minWidth: 200,
                  height: 50.0,
                  color: Colors.tealAccent[700],
                  onPressed: () {
                    Navigator.pushNamed(context, PairingScreen.id);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
