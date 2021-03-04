import 'package:flutter/material.dart';

final kRoundedBoxBorder = BoxDecoration(
  borderRadius: BorderRadius.circular(15.0),
  border: Border.all(color: Colors.tealAccent[700], width: 3.0),
);

// Bluetooth UUIDs
const String kLeftShoeServiceID = "533e7ee6-25b0-11eb-adc1-0242ac120002";
const String kLeftShoeDistID = "533e8300-25b0-11eb-adc1-0242ac120002";
const String kLeftShoeAccXID = "533e840e-25b0-11eb-adc1-0242ac120002";
const String kLeftShoeAccYID = "533e84d6-25b0-11eb-adc1-0242ac120002";
const String kLeftShoeAccZID = "533e859e-25b0-11eb-adc1-0242ac120002";
