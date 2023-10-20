import 'package:flutter/material.dart';

class DeactivateWidget extends StatelessWidget {
  final Widget child;
  final bool isActive;

  const DeactivateWidget({Key? key, this.isActive = true, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: isActive ? 1.0 : 0.3,
        child: child,
      ),
    );
  }
}
