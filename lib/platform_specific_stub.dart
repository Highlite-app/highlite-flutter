// lib/platform_specific_stub.dart
import 'package:highlite_flutter_mvp/platform_specific.dart';


class StubPlatformSpecific implements PlatformSpecific {
  @override
  void doSomething() {
    print('This feature is not supported on this platform.');
  }
}

PlatformSpecific getPlatformSpecificImplementation() {
  return StubPlatformSpecific();
}
