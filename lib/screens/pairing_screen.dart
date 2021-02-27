//.. Pairing screen that shows progress of connecting to both BLE Device and only
//.. allow to proceed with measuring gait characteristics once fully initiallized

import 'package:flutter/material.dart';
import 'package:stryde_app/components/rounded_button.dart';
import 'package:stryde_app/constants.dart';
import 'package:stryde_app/screens/information_screen.dart';
import 'package:flutter_blue/flutter_blue.dart';

class PairingScreen extends StatefulWidget {
  static const String id = 'pairing_screen';
  @override
  _PairingScreenState createState() => _PairingScreenState();
}

class _PairingScreenState extends State<PairingScreen> {
  bool dev1Connected = false;
  bool dev2Connected = false;
  FlutterBlue flutterBlue = FlutterBlue.instance;

  @override
  void initState() {
    super.initState();
    flutterBlue.startScan(timeout: Duration(seconds: 4));
    print('Scan Started');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 25, right: 25.0, top: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //..LOGO AND TITLE..//
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Image.asset('images/logo.png'),
                  height: 40,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Connecting to Device',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            //..LEFT ANF RIGHT SHOE CONNECTION..//
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                decoration: kRoundedBoxBorder,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 60.0,
                      child: Image.asset('images/left.png'),
                    ),

                    // Show progress indicator until device 1 is connected
                    dev1Connected
                        ? Text(
                            'Connected',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        : CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                decoration: kRoundedBoxBorder,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 60.0,
                      child: Image.asset('images/right.png'),
                    ),

                    // Show progress indicator until device 2 is connected
                    dev2Connected
                        ? Text(
                            'Connected',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        : CircularProgressIndicator(),
                  ],
                ),
              ),
            ),

            // Showing the Begin Testing only when both devices are connected
            dev1Connected && dev2Connected
                ? RoundedButton(
                    title: 'Begin Test',
                    onPressed: () {
                      Navigator.pushNamed(context, InfoScreen.id);
                    },
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
