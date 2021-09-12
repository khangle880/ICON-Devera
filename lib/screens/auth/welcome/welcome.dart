import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/global/constants/assets_path.dart';
import 'package:icon/route/app_routes.dart';
import 'package:icon/utils/extensions/color.dart';
import 'package:icon/widgets/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).buttonColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          SizedBox(height: 120.h),
          SvgPicture.asset(AssetPathConstants.logoImage),
          SizedBox(height: 29.h),
          SvgPicture.asset(AssetPathConstants.welcomeTextImage),
          SizedBox(height: 296.h),
          RoundedButton(
            text: "Sign In",
            backgroundColor: ExpandedColor.fromHex("#FFFFFF"),
            textColor: ExpandedColor.fromHex("#347AF0"),
            onPressed: () {
              Routes.pushNamed(RouteNames.login);
            },
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don’t have an account? ",
                style: textTheme.bodyText2!
                    .copyWith(color: Theme.of(context).primaryColorLight),
              ),
              GestureDetector(
                onTap: () => Routes.pushNamed(RouteNames.signUp),
                child: Text(
                  "Sign Up",
                  style: textTheme.button!
                      .copyWith(color: Theme.of(context).primaryColorLight),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
