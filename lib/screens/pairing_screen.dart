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
  bool dev2Connected = true; //TODO: remember to enable right shoe
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice leftShoe;
  BluetoothDevice rightShoe;
  List<ScanResult> deviceList;

  @override
  void initState() {
    super.initState();
    flutterBlue.startScan();
    print('Scan Started');

    // Connecting to device
    _connect2Device();
  }

  @override
  void dispose() {
    super.dispose();
    flutterBlue.stopScan();
  }

  //Attempts to locate device and connect
  void _connect2Device() {
    flutterBlue.scanResults.listen((results) {
      for (var result in results) {
        if (result.device.name == 'Left Shoe') {
          leftShoe = result.device;
          leftShoe.connect();
          print('LEFT connected!!!');
          _isConnected(leftShoe.name);
        } else if (result.device.name == 'Right Shoe') {
          // rightShoe = result.device;
          // rightShoe.connect();
          // print('RIGHT connected!!!!');
          // _isConnected(rightShoe.name);
        }
      }
    });
  }

  //Check whether device is connected and show status
  void _isConnected(String name) {
    if (name == 'Left Shoe') {
      if (leftShoe == null) {
        setState(() {
          dev1Connected = false;
        });
      } else {
        setState(() {
          dev1Connected = true;
        });
      }
    } else if (name == 'Right Shoe') {
      // if (rightShoe == null) {
      //   setState(() {
      //     dev2Connected = false;
      //   });
      // } else {
      //   setState(() {
      //     dev2Connected = true;
      //   });
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        children: [
          // Home Button
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 40, bottom: 20),
              child: FloatingActionButton(
                heroTag: null,
                elevation: 3,
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (leftShoe != null) {
                    leftShoe.disconnect();
                  }
                  if (rightShoe != null) {
                    rightShoe.disconnect();
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: FloatingActionButton.extended(
                label: Text(
                  'Reset',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                elevation: 3,
                onPressed: () {
                  // Disconnect the devices if connected and Try reconnecting
                  if (leftShoe != null) {
                    leftShoe.disconnect();
                  }
                  if (rightShoe != null) {
                    rightShoe.disconnect();
                  }
                  _connect2Device();
                },
              ),
            ),
          ),
        ],
      ),
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
                      flutterBlue.stopScan();
                      Navigator.pushReplacementNamed(context, InfoScreen.id,
                          arguments: {
                            'device1': leftShoe,
                            'device2': rightShoe
                          });
                    },
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
