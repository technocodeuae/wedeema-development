import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/utils/screen_utils/device_utils.dart';

class TextFieldDecorator extends StatefulWidget {
  final Widget child;
  final double? height;
  final double? width;
  final bool? haveBorder;
  TextFieldDecorator({Key? key, required this.child, this.height,this.width,this.haveBorder = true }) : super(key: key);

  @override
  _TextFieldDecoratorState createState() => _TextFieldDecoratorState();
}

class _TextFieldDecoratorState extends State<TextFieldDecorator> {
  final GlobalKey _textFieldKey = GlobalKey();
  double? _widgetHeight;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _widgetHeight ??=
          (_textFieldKey.currentContext?.findRenderObject() as RenderBox?)
              ?.size
              .height;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.width??ScreenHelper.width55,
          height: widget.height??45.sp,
          decoration: widget.haveBorder == true?AppStyle.formFieldDecoration:null,
        ),
        Container(
          height: widget.height??45.sp,
          key: _textFieldKey,
          child: widget.child,
        )
      ],
    );
  }
}
