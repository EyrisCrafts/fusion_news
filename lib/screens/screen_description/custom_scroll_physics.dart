import 'package:flutter/material.dart';

class CustomScrollPhysics extends ScrollPhysics {
  const CustomScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.pixels && position.atEdge) {
      return position.pixels - value;
    }
    return 0.0;
  }
}