import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/global/constants/assets_path.dart';

import 'simple_rive_widget.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SimpleRiveWidget(
              rivePath: AssetPathConstants.loader1Rive,
              simpleAnimation: AssetPathConstants.loader1SimpleAnimation,
              width: 80.w,
              height: 120.h,
            ),
          ],
        ),
      ),
    );
  }
}
