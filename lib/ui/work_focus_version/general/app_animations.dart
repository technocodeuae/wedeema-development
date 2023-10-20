import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({
    this.transitionType = ContainerTransitionType.fade,
    this.onClosed,
    this.middleColor,
    this.openElevation = 0.0,
    this.closedElevation = 0.0,
    this.openColor = Colors.transparent,
    this.closedColor = Colors.transparent,
    this.closedShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(0.0)),
    ),
    this.openShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
    ),
    required this.openBuilder,
    required this.closedBuilder,
  });

  final ContainerTransitionType transitionType;
  final Widget Function(VoidCallback closedBuilder) openBuilder;
  final Widget Function(VoidCallback openBuilder) closedBuilder;
  final ClosedCallback? onClosed;
  final Color? middleColor;
  final Color closedColor;
  final Color openColor;
  final double openElevation;
  final double closedElevation;
  final ShapeBorder closedShape;
  final ShapeBorder openShape;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      tappable: false,
      onClosed: onClosed,
      openColor: openColor,
      openShape: openShape,
      middleColor: middleColor,
      closedColor: closedColor,
      closedShape: closedShape,
      openElevation: openElevation,
      transitionType: transitionType,
      closedElevation: closedElevation,
      // useRootNavigator: false,
      openBuilder: (BuildContext context, VoidCallback closedBuilder) {
        return openBuilder(closedBuilder);
      },
      closedBuilder: (BuildContext context, VoidCallback openBuilder) {
        return closedBuilder(openBuilder);
      },
    );
  }
}

class FadeThroughTransitionPageWrapper extends StatefulWidget {
  const FadeThroughTransitionPageWrapper({
    required this.child,
    required this.transitionKey,
  }) : super(key: transitionKey);

  final Widget child;
  final ValueKey transitionKey;

  @override
  State<FadeThroughTransitionPageWrapper> createState() =>
      _FadeThroughTransitionPageWrapperState();
}

class _FadeThroughTransitionPageWrapperState
    extends State<FadeThroughTransitionPageWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _drawerController;
  final _kAnimationDuration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();

    _drawerController = AnimationController(
      duration: _kAnimationDuration,
      value: 0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _drawerController.dispose();
    super.dispose();
  }

  // @override
  // Route createRoute(BuildContext context) {
  //   AnimatedSwitcher(
  //     duration: Duration(milliseconds: 500),
  //     child: widget.child,
  //     transitionBuilder: (
  //       child,
  //       animation,
  //     ) {
  //       return FadeThroughTransition(
  //         fillColor: Theme.of(context).scaffoldBackgroundColor,
  //         animation: animation,
  //         secondaryAnimation: animation,
  //         child: widget.child,
  //       );
  //     },
  //   );
  // /*  FadeThroughTransition(
  //     fillColor: Theme.of(context).scaffoldBackgroundColor,
  //     animation: _dropArrowCurve,
  //     secondaryAnimation: secondaryAnimation,
  //     child: widget.child,
  //   );
  //   return PageRouteBuilder(
  //     settings: this,
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       return;
  //     },
  //     pageBuilder: (context, animation, secondaryAnimation) {
  //       return widget.child;
  //     },
  //   );*/
  // }

  @override
  Widget build(BuildContext context) {
    // return widget.child;
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: widget.child,
      transitionBuilder: (
        child,
        animation,
      ) {
        return FadeThroughTransition(
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          secondaryAnimation: _drawerController,
          animation: animation,
          child: widget.child,
        );
      },
    );
  }
}
