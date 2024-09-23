
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../core/services/injection_container.dart';

final BuildContext buildContext =  sl<NavigationService>().navigationKey.currentContext!;

@lazySingleton
class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;
}
