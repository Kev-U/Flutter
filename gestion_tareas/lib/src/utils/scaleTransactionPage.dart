import 'package:flutter/material.dart';

class ScaleTransactionPage extends PageRouteBuilder{
  final Widget page;

  ScaleTransactionPage(this.page)
      :super(
      pageBuilder: (context, animation, anotherAnimation)
      => page, transitionDuration: Duration(milliseconds: 1500),
    reverseTransitionDuration: Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, anotherAnimation, child)
    {
      animation = CurvedAnimation(
          parent: animation,
          curve: Curves.fastLinearToSlowEaseIn,
          reverseCurve: Curves.fastOutSlowIn
      );
      return ScaleTransition(
        scale: animation, alignment: Alignment.bottomRight, child: child
      );
    },
  );
}