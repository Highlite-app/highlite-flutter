

import 'package:highlite_flutter_mvp/platform_specific.dart';

import 'app.dart';
import 'core/environment/base_environment.dart';

void main() async {
  // Use the platform-specific implementation
  // Get the platform-specific implementation
  // PlatformSpecific platformSpecific = getPlatformSpecificImplementation();
  //
  // // Execute the platform-specific function
  // platformSpecific.doSomething();
  //
  //
  // // Execute the platform-specific function
  // platformSpecific.doSomething();
  await app(BaseEnvironment.development);
}
