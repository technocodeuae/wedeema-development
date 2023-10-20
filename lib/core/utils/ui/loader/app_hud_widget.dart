// import 'package:flutter/material.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
// import '../../../../core/utils/ui/loader/app_loader_widget.dart';
//
// class LoadingOverlayWidget extends StatelessWidget {
//   final bool isLoading;
//   final Widget? loader;
//   final String? loadingComment;
//   final Widget child;
//
//   const LoadingOverlayWidget(
//       {Key? key,
//       required this.isLoading,
//       required this.child,
//       this.loader,
//       this.loadingComment})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ModalProgressHUD(
//       inAsyncCall: isLoading,
//       child: child,
//       color: Colors.grey.shade900.withOpacity(0.4),
//       progressIndicator: loader ??
//           AppLoaderWidget(
//             loadingComment: loadingComment,
//           ),
//     );
//   }
// }
