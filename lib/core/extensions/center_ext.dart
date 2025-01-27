import 'package:flutter/widgets.dart';

extension SetNewValueToInt on int {
  String toAntoerString() {
    return "";
  }
}

extension CenterToWidget on Widget {
  Widget setCenter() {

    return Center(
      child: this,
    );

  }
}
