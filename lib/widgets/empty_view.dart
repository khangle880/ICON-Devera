import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/global/constants/assets_path.dart';

import 'simple_rive_widget.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(
              flex: 2,
            ),
            SimpleRiveWidget(
              rivePath: AssetPathConstants.loadingCatRive,
              simpleAnimation: AssetPathConstants.loadingCatSimpleAnimation,
              width: 150.h,
              height: 150.h,
            ),
            Text("No thing but us",
                style: Theme.of(context).textTheme.subtitle1),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
