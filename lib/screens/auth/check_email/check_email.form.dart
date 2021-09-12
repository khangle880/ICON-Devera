import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/route/app_routes.dart';
import 'package:icon/screens/auth/forgot_password/bloc/reset_password_bloc.dart';
import 'package:icon/screens/components/process_state.dart';
import 'package:icon/utils/extensions/extensions.dart';
import 'package:icon/utils/validator/auth_validators.dart';
import 'package:icon/widgets/normal_text_field.dart';
import 'package:icon/widgets/rounded_button.dart';


class CheckOtpForm extends StatefulWidget {
  const CheckOtpForm({Key? key}) : super(key: key);

  @override
  _CheckOtpFormState createState() => _CheckOtpFormState();
}

class _CheckOtpFormState extends State<CheckOtpForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        final checkOtpStatus = state.checkOtpStatus;
        if (checkOtpStatus is Processing) {
          ExpandedSnackBar.showLoadingSnackBar(
            context,
            "Verifing otp...",
          );
        }

        if (checkOtpStatus is ProcessFailure) {
          ExpandedSnackBar.showFailureSnackBar(
              context,
              checkOtpStatus.errorMessage,
            );
        }

        if (checkOtpStatus is ProcessSuccess) {
          ExpandedSnackBar.showSuccessSnackBar(
              context,
              "OTP Correct!",
            );
          Future.delayed(const Duration(milliseconds: 1000), () {
            Routes.pushNamed(RouteNames.createNewPassword,
                navigator: Routes.forgotPassNavigator);
          });
        }
      },
      builder: (context, state) => Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NormalTextField(
                labelText: "OTP",
                onChange: (value) {
                  context
                      .read<ResetPasswordBloc>()
                      .add(OtpOnChange(otp: value));
                },
              ),
              SizedBox(height: 50.h),
              RoundedButton(
                text: 'Verify Otp',
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      state.checkOtpStatus is! Processing) {
                    context.read<ResetPasswordBloc>().add(VerifyOtp());
                  }
                },
              ),
              SizedBox(height: 10.h),
              RoundedButton(
                text: 'Back to Login',
                backgroundColor: Colors.transparent,
                textColor: Theme.of(context).buttonColor,
                onPressed: () {
                  Routes.pop(navigator: Routes.signInNavigator);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
