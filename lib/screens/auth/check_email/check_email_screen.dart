import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icon/global/constants/assets_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/route/app_routes.dart';
import 'package:icon/widgets/custom_header.dart';
import 'package:icon/widgets/input_panel.dart';

import 'check_email.form.dart';

class CheckEmailPage extends StatefulWidget {
  const CheckEmailPage({Key? key}) : super(key: key);

  @override
  _CheckEmailPageState createState() => _CheckEmailPageState();
}

class _CheckEmailPageState extends State<CheckEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity),
            SizedBox(height: 50.h),
            CustomHeader(
              onPressedBack: () {
                Routes.pop(navigator: Routes.forgotPassNavigator);
              },
              title: "Check Your Email",
              subtitle:
                  "Follow a password recovery instructions we have just sent to your email address",
            ),
            SizedBox(height: 125.h),
            SvgPicture.asset(AssetPathConstants.emailIllusImage),
            Spacer(),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: InputPanel(
            height: 250.h,
            child: CheckOtpForm(),
          ),
        )
      ]),
    );
  }
}
