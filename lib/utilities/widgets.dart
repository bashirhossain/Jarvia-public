import 'package:flutter/material.dart';
import 'dart:math' as math;
class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Container(
      height: 60,
      width: 120,

      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.deepPurple)),
        onPressed: onPressed,
        child: child,
      ),
    ),
  );
}
class Header extends StatelessWidget {
  const Header(this.heading);
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      heading,
      style: const TextStyle(fontSize: 24),
    ),
  );
}

class SliverHeadBarDelegate extends SliverPersistentHeaderDelegate{
  SliverHeadBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child
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
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent)
  {
    return new SizedBox.expand(child: child);
  }
  @override
  bool shouldRebuild(SliverHeadBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

const Map<String, MaterialColor> QuadrantColorMapping = {
  "Quadrant 1": Colors.deepOrange,
  "Quadrant 2": Colors.lightGreen,
  "Quadrant 3": Colors.blueGrey,
  "Quadrant 4": Colors.purple,
  "": Colors.grey
};