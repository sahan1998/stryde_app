import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:stryde_app/components/line_graph.dart';
import 'package:stryde_app/constants.dart';

class InfoScreen extends StatefulWidget {
  static const String id = 'info_screen';
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  Map data = {};
  Map traceData = {'dist': [], 'LxVal': [], 'LyVal': [], 'LzVal': []};
  bool isReady = false; //check for assigning all characteristics.
  // Left Shoe
  BluetoothDevice leftShoe;
  BluetoothService leftShoeService;
  BluetoothCharacteristic leftShoeDist,
      leftShoeAccX,
      leftShoeAccY,
      leftShoeAccZ;
  double leftDist, leftXVal, leftYVal, leftZVal = 0;
  Stream<List<Map>> leftShoeDataStream;
  //Right Shoe
  BluetoothDevice rightShoe;
  BluetoothService rightShoeService;
  BluetoothCharacteristic rightShoeDist,
      rightShoeAccX,
      rightShoeAccY,
      rightShoeAccZ;
  double rightDist, rightXVal, rightYVal, rightZVal = 0;

  int validCounter = 0, invalidCounter = 0;

  void _findServicesCharacteristics(device) async {
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      // print(service);
      if (service.uuid.toString() == kLeftShoeServiceID) {
        leftShoeService = service;
        _getCharacteristics(leftShoeService);
      }
    });
  }

  void _getCharacteristics(service) async {
    var characteristics = service.characteristics;
    for (BluetoothCharacteristic c in characteristics) {
      // List<int> value = await c.read();
      // c.print(c);
      await c.setNotifyValue(true);

      // Separating Characteristics
      if (c.uuid.toString() == kLeftShoeDistID) {
        leftShoeDist = c;
      } else if (c.uuid.toString() == kLeftShoeAccXID) {
        leftShoeAccX = c;
      } else if (c.uuid.toString() == kLeftShoeAccYID) {
        leftShoeAccY = c;
      } else if (c.uuid.toString() == kLeftShoeAccZID) {
        leftShoeAccZ = c;
      }
    }
    setState(() {
      isReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Attaching devices paired from previous screen and finding services
    data = ModalRoute.of(context).settings.arguments;
    leftShoe = data['device1'];
    rightShoe = data['device2'];
    _findServicesCharacteristics(leftShoe);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 40),
        child: Column(
          children: [
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
                  'Shoe Data',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            (isReady)
                ? StreamBuilder<List<int>>(
                    stream: leftShoeAccX.value,
                    builder: (context, snapshot) {
                      var reading;
                      if (snapshot.hasData && snapshot.data.length > 0) {
                        // print(snapshot.data.length);
                        var bytes = Int8List.fromList(snapshot.data);
                        var data = ByteData.view(bytes.buffer);
                        reading = data.getInt16(0, Endian.little);
                        validCounter++;
                      } else {}

                      return LineCurve();
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
