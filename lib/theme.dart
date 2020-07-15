import 'package:flutter/material.dart';

class MfColors {
  MfColors._(); // this basically makes it so you can instantiate this class

  static const dark = Color(0xFF061134);
  static const gray = Color(0xFF585468);
  static const light = Color(0xFFE0EAE7);
  static const white = Color(0xFFFFFFFF);
  static const primary = MaterialColor(0xFF18AC91, <int, Color>{
    100: Color(0xFFDBEBE6),
    400: Color(0xFF18AC91),
  });
}
