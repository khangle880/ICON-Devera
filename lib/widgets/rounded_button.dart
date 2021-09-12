import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/utils/extensions/extensions.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF347AF0),
    this.textColor = const Color(0xFFFFFFFF),
    this.padding,
  }) : super(key: key);

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsetsGeometry? padding;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 88.w),
        width: double.infinity,
        height: 48.h,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
              primary: ExpandedColor.fromHex("#313131"),
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23.r))),
          child: Text(text,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: textColor)),
        ));
  }
}
