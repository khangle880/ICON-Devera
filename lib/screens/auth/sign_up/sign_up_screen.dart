import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icon/global/constants/assets_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/widgets/input_panel.dart';

import 'sign_up_form.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
              Text("Create Account", style: textTheme.headline5),
              SizedBox(height: 60.h),
              SvgPicture.asset(AssetPathConstants.officeIllusImage),
              Spacer()
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: InputPanel(
              height: 490.h,
              child: SignUpForm(),
            ),
          )
        ],
      ),
    );
  }
}
