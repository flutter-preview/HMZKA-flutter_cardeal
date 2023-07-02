import 'package:flutter/material.dart';

Map<String, dynamic> manufacturer = {
  "acura": 0,
  "alfa-romeo": 1,
  "aston-martin": 2,
  "audi": 3,
  "bmw": 4,
  "buick": 5,
  "cadillac": 6,
  "chevrolet": 7,
  "chrysler": 8,
  "dodge": 9,
  "fiat": 10,
  "ford": 11,
  "gmc": 12,
  "harley-davidson": 13,
  "honda": 14,
  "hyundai": 15,
  "infiniti": 16,
  "jaguar": 17,
  "jeep": 18,
  "kia": 19,
  "land rover": 20,
  "lexus": 21,
  "lincoln": 22,
  "mazda": 23,
  "mercedes-benz": 24,
  "mercury": 25,
  "mini": 26,
  "mitsubishi": 27,
  "nissan": 28,
  "pontiac": 29,
  "porsche": 30,
  "ram": 31,
  "rover": 32,
  "saturn": 33,
  "subaru": 34,
  "tesla": 35,
  "toyota": 36,
  "volkswagen": 37,
  "volvo": 38,
};
Map<String, dynamic> type = {
  "SUV": 0,
  "bus": 1,
  "convertible": 2,
  "coupe": 3,
  "hatchback": 4,
  "mini-van": 5,
  "offroad": 6,
  "other": 7,
  "pickup": 8,
  "sedan": 9,
  "truck": 10,
  "van": 11,
  "wagon": 12,
};
Map<String, dynamic> transmission = {"automatic": 0, "manual": 1};
Map<String, dynamic> fuel = {"diesel": 0, "electric": 1, "gas": 2, "hybrid": 3};
Map<String, dynamic> condition = {
  "excellent": 0,
  "fair": 1,
  "good": 2,
  "like new": 3,
  "salvage": 4
};
final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
