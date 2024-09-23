import 'package:flutter/services.dart';

class Keyboard {
  static void hide() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static void show() {
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  static void invoke(bool visible) {
    if (!visible) {
      Keyboard.hide();
    } else {
      Keyboard.show();
    }
  }
}
