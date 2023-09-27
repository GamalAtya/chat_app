

import 'package:flutter/material.dart';

extension ScreenSize on BuildContext {

  double get screenHeight {
    return MediaQuery.of(this).size.height ;
  }
  double get screenWidth {
    return MediaQuery.of(this).size.width ;
  }

}