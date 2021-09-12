import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader(
      {Key? key,
      required this.onPressedBack,
      required this.title,
      required this.subtitle})
      : super(key: key);
  final VoidCallback onPressedBack;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: InkWell(
                onTap: onPressedBack,
                child: Container(
                    padding: EdgeInsets.fromLTRB(8.h, 10.h, 12.h, 10.h),
                    child: Icon(Icons.arrow_back_ios_new, size: 20.w)),
              ),
            ),
            Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: 52.w),
          ],
        ),
        SizedBox(height: 8.h, width: double.infinity),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ],
    );
  }
}
