
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'injection_container.dart';

final BuildContext buildContext =  sl<NavigationService>().navigationKey.currentContext!;

@Injectable(as: NavigationService)
class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;
}
