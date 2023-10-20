import 'package:flutter/material.dart';

class FlexibleText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final FlexFit? flexFit;

  const FlexibleText(
    this.data, {
    Key? key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.textOverflow,
    this.flexFit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: flexFit ?? FlexFit.loose,
      child: Text(
        data,
        textAlign: textAlign,
        style: style,
        maxLines: maxLines,
        overflow: textOverflow,
      ),
    );
  }
}
