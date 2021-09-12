import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon/utils/extensions/extensions.dart';

class KeyBoardInput extends StatelessWidget {
  const KeyBoardInput({
    Key? key,
    required this.number,
    required this.onPressed,
  }) : super(key: key);

  final String number;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100.r),
      splashColor: Colors.white,
      highlightColor: Colors.white,
      onTap: onPressed,
      child: Container(
        width: 81.h,
        height: 81.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            // shape: BoxShape.circle,
            ),
        child: Text(
          number,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 39.sp,
            color: ExpandedColor.fromHex("#003282"),
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
