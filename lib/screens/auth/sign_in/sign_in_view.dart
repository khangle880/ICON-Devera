import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icon/global/constants/assets_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/widgets/input_panel.dart';

import 'sign_in_form.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity),
              SizedBox(height: 50.h),
              Text("Welcome Back!", style: textTheme.headline5),
              SizedBox(height: 50.h),
              SvgPicture.asset(AssetPathConstants.loginIllusImage),
              Spacer()
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: InputPanel(
              height: 444.h,
              child: SignInForm(),
            ),
          )
        ],
      ),
    );
  }
}
