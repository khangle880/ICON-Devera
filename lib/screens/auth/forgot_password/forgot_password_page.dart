import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/route/app_routes.dart';
import 'package:icon/widgets/custom_header.dart';
import 'package:icon/widgets/input_panel.dart';

import 'forgot_pass_form.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity),
              SizedBox(height: 50.h),
              CustomHeader(
                onPressedBack: () {
                  Routes.pop(navigator: Routes.signInNavigator);
                },
                title: "Forgot Password?",
                subtitle:
                    "Enter your registrated email address to receive password reset instruction",
              ),
              Spacer(),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: InputPanel(height: 250.h, child: ForgotPasswordForm()),
          )
        ],
      ),
    );
  }
}
