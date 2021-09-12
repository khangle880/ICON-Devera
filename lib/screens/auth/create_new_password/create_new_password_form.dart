import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/route/app_routes.dart';
import 'package:icon/screens/auth/forgot_password/bloc/reset_password_bloc.dart';
import 'package:icon/screens/components/process_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon/utils/extensions/extensions.dart';
import 'package:icon/utils/validator/auth_validators.dart';
import 'package:icon/widgets/normal_text_field.dart';
import 'package:icon/widgets/obscure_text_field.dart';
import 'package:icon/widgets/rounded_button.dart';

class CreateNewPasswordForm extends StatefulWidget {
  const CreateNewPasswordForm({Key? key}) : super(key: key);

  @override
  _CreateNewPasswordFormState createState() => _CreateNewPasswordFormState();
}

class _CreateNewPasswordFormState extends State<CreateNewPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? input) {
    if (input != null && AuthValidators.isValidPassword(input)) {
      return null;
    } else {
      return "Password Invalid";
    }
  }

  String? _validateConfirmPassword(String? input) {
    if (input != null && _newPasswordController.text == input) {
      return null;
    } else {
      return "Not same new password";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        final createNewPassStatus = state.createNewPassStatus;
        if (createNewPassStatus is Processing) {
          ExpandedSnackBar.showLoadingSnackBar(
            context,
            "Creating...",
          );
        }

        if (createNewPassStatus is ProcessFailure) {
          ExpandedSnackBar.showFailureSnackBar(
            context,
            createNewPassStatus.errorMessage,
          );
        }

        if (createNewPassStatus is ProcessSuccess) {
          ExpandedSnackBar.showSuccessSnackBar(
            context,
            "Create Password Successfully!",
          );
          Routes.pop();

          // Routes.pop(navigator: Routes.signInNavigator);
        }
      },
      builder: (context, state) => Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ObscureTextField(
                labelText: "New password",
                controller: _newPasswordController,
                validator: _validatePassword,
                onChange: (value) {
                  context
                      .read<ResetPasswordBloc>()
                      .add(NewPasswordOnChange(password: value));
                },
              ),
              ObscureTextField(
                labelText: "Repeat password",
                controller: _confirmPasswordController,
                validator: _validateConfirmPassword,
              ),
              SizedBox(height: 50.h),
              RoundedButton(
                text: 'Send Request',
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      state.createNewPassStatus is! Processing) {
                    context.read<ResetPasswordBloc>().add(SubmitNewPassword());
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
