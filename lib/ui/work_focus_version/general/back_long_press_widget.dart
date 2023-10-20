import 'package:flutter/material.dart';

import '../../../blocs/application/application_bloc.dart';
import '../../../core/di/di_manager.dart';

class BackLongPress extends StatelessWidget {
  final Widget child;

  const BackLongPress({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
    // bool _startedFromLeft = false;
    // bool _startedFromRight = false;
    // late Offset previousLocalPosition;
    //
    //
    // return GestureDetector(
    //
    //   onHorizontalDragUpdate: (details) {
    //
    //     print("JJJJJJJ" + details.localPosition.dx.toString());
    //     if (DIManager.findDep<ApplicationCubit>().appLanguage.languageCode ==
    //         "en" && details.localPosition.dx > 0 && details.localPosition.dx >
    //         MediaQuery.of(context).size.width * 0.90) {
    //
    //       Navigator.of(context).pop();
    //
    //       // Dragging from left to right
    //       print('Dragging from left to right');
    //       // Perform your action here
    //     } else if( DIManager.findDep<ApplicationCubit>().appLanguage.languageCode ==
    //         "ar" && details.localPosition.dx < MediaQuery.of(context).size.width *0.10 && details.localPosition.dx > 0 ){
    //       // Dragging from right to left or not horizontal
    //
    //       Navigator.of(context).pop();
    //
    //       print('Dragging from right to left');
    //     }
    //   },
    //   onLongPressStart: (details) {
    //     if (details.localPosition.dx < MediaQuery.of(context).size.width *90) {
    //       // Left edge
    //       _startedFromLeft = true;
    //       previousLocalPosition = details.localPosition;
    //     } else if (details.localPosition.dx >
    //         MediaQuery.of(context).size.width * 10) {
    //       // Right edge
    //       _startedFromRight = true;
    //       previousLocalPosition = details.localPosition;
    //     }
    //   },
    //   onLongPressMoveUpdate: (details) {
    //     if (_startedFromLeft &&
    //         previousLocalPosition.dx < details.localPosition.dx) {
    //       // Dragging from left to right
    //       previousLocalPosition = details.localPosition;
    //     }
    //     if (_startedFromRight &&
    //         previousLocalPosition.dx > details.localPosition.dx) {
    //       // Dragging from right to left
    //       previousLocalPosition = details.localPosition;
    //     }
    //   },
    //   onLongPressEnd: (details) {
    //     if (_startedFromLeft &&
    //         DIManager.findDep<ApplicationCubit>().appLanguage.languageCode ==
    //             "ar" &&
    //         details.velocity.pixelsPerSecond.dx! > 0) {
    //       Navigator.of(context).pop();
    //     } else if (_startedFromRight &&
    //         DIManager.findDep<ApplicationCubit>().appLanguage.languageCode ==
    //             "en" &&
    //         details.velocity.pixelsPerSecond.dx! < 0) {
    //       // Swipe from right to left
    //       Navigator.of(context).pop();
    //     }
    //   },
    //   child: child,
    // );
  }
}
