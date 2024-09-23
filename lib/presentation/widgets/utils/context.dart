import 'package:flutter/cupertino.dart';

extension ContextExtentions on BuildContext{

  bool get mounted {
    try{
      widget;
      return true  ;
    }catch(e){
      return false ;

    }
  }


  NavigatorState get navigator{
    return  Navigator.of(this);
  }

  NavigatorState get rootNavigator {
    return Navigator.of(this, rootNavigator: true);
  }
}