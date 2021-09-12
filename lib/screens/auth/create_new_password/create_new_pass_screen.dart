import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/route/app_routes.dart';
import 'package:icon/utils/validator/auth_validators.dart';
import 'package:icon/widgets/custom_header.dart';
import 'package:icon/widgets/input_panel.dart';

import 'create_new_password_form.dart';

class CreateNewPasswordPage extends StatefulWidget {
  const CreateNewPasswordPage({Key? key}) : super(key: key);

  @override
  _CreateNewPasswordPageState createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {

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
                title: "Create New Password",
                subtitle:
                    "Your new password must be different from a previously used password",
              ),
              Spacer(),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: InputPanel(height: 450.h, child: CreateNewPasswordForm()),
          )
        ],
      ),
    );
  }
}
