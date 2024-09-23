import 'package:flutter/material.dart';
import '../../presentation/widgets/utils/navigation_service.dart';
import '../services/injection_container.dart';

final BuildContext context =
    sl<NavigationService>().navigationKey.currentContext!;
