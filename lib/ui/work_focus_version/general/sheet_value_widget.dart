import 'package:flutter/material.dart';
import '../../../../core/utils/screen_utils/device_utils.dart';
import '../../../../core/utils/ui/widgets/utils/horizontal_padding.dart';

class SheetValueWidget extends StatelessWidget {
  final Widget child;
  final double? width;

  const SheetValueWidget({Key? key, required this.child, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenHelper.fromHeight55(4.0),
      // width: width??ScreenHelper.fromWidth(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          child,
          HorizontalPadding(2.0),
          Icon(
            Icons.arrow_drop_down_outlined,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
