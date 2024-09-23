import 'package:flutter/material.dart';

mixin BaseAppBar implements PreferredSizeWidget {
  final AppBar appBar = AppBar();
  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
