import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/route/app_routes.dart';
import 'package:icon/screens/components/process_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon/utils/extensions/extensions.dart';
import 'package:icon/utils/validator/auth_validators.dart';
import 'package:icon/widgets/normal_text_field.dart';
import 'package:icon/widgets/rounded_button.dart';

import 'bloc/reset_password_bloc.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? input) {
    if (input != null && AuthValidators.isValidEmail(input)) {
      return null;
    } else {
      return "Invalid email";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        final sendEmailStatus = state.sendEmailStatus;
        if (sendEmailStatus is Processing) {
          ExpandedSnackBar.showLoadingSnackBar(
            context,
            "Sending otp...",
          );
        }

        if (sendEmailStatus is ProcessFailure) {
          ExpandedSnackBar.showFailureSnackBar(
            context,
            "OTP was not sent failure",
          );
        }

        if (sendEmailStatus is ProcessSuccess) {
          ExpandedSnackBar.showSuccessSnackBar(
            context,
            "OTP sent successfully !",
          );
          Future.delayed(const Duration(milliseconds: 1000), () {
            Routes.pushNamed(RouteNames.checkEmail,
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
                labelText: "Email address",
                autofocus: true,
                // hintText: "Enter your email",
                validator: _validateEmail,
                onChange: (value) {
                  context
                      .read<ResetPasswordBloc>()
                      .add(EmailOnChange(email: value));
                },
              ),
              SizedBox(height: 50.h),
              RoundedButton(
                text: 'Send Request',
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      state.sendEmailStatus is! Processing) {
                    context
                        .read<ResetPasswordBloc>()
                        .add(ResetPassSendRequest());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
