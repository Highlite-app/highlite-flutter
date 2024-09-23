// lib/platform_specific_interface.dart
abstract class PlatformSpecific {
  void doSomething();
}

class StubPlatformSpecific implements PlatformSpecific {
  @override
  void doSomething() {
    // Fallback for non-Windows platforms
    print('This feature is not supported on this platform.');
  }
}

PlatformSpecific getPlatformSpecificImplementation() {
  return StubPlatformSpecific();
}
