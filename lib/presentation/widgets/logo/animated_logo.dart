import 'package:flutter/material.dart';

import '../../../core/resources/asset_constants.dart';

class AnimatedLogo extends StatefulWidget {
  final Widget? child ;
  const AnimatedLogo({
    this.child ,
    super.key});

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>  with SingleTickerProviderStateMixin{
  
  AnimationController? _animationController ;
  Animation<double>? _animation ; 
  
  
  @override
  void initState() {
    _animationController = AnimationController(duration: const Duration(milliseconds:200 ) , vsync: this) ;
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
        parent: _animationController!, curve: Curves.bounceInOut)) ..addStatusListener((status) {
       if(status == AnimationStatus.completed){
         _animationController!.reverse() ;

       }else if(status == AnimationStatus.dismissed){
         _animationController!.stop();
       }
    });
    _animationController!.forward() ;
    super.initState();
  }

  void restartAnimation() {
    if (!_animationController!.isAnimating) {
      _animationController?.forward(from: 0.0);  // Restart from the beginning
    }
  }

  @override
  void dispose() {
   _animationController!.dispose() ;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: restartAnimation,
      child: ScaleTransition(
          scale: _animation! ,
         child:widget.child?? SizedBox(
        width: 40,
        height: 40,
        child: Image.asset(

        AssetConstant.icHighLiteSMLogoSmallPng

    ),
      ),
    )
    );
  }
}