import 'package:flutter/material.dart';
class LoadingColumnOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingColumnOverlay({
    required this.isLoading,
    required this.child,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
         child,
        if (isLoading)
          Opacity(
            opacity: 0.3,
            child: ModalBarrier(dismissible: false, color: Colors.transparent),
          ),
        if (isLoading) Center(child: Image.asset(
          "assets/images/wadeema_loader.gif",
          height: 125.0,
          width: 125.0,
        ),),
      ],
    );
  }
}