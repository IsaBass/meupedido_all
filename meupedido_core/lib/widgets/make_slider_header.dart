import 'dart:math' as math;

import 'package:flutter/material.dart';

SliverPersistentHeader makeSliverHeader(
    {Widget child, double minHeight, double maxHeight, bool pinned = true,
    Color backgroundColor = Colors.transparent}) {
  return SliverPersistentHeader(
    pinned: pinned,
    delegate: _SliverAppBarDelegate(
      minHeight: minHeight,
      maxHeight: maxHeight,
      child: Container(
        color: backgroundColor,
        child: Center(
          child: child,
          // child: TextField(),
        ),
      ),
    ),
  );
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return  SizedBox.expand(child: child);
  }


  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
