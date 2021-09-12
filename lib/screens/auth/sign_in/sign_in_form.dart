import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon/route/app_routes.dart';
import 'package:icon/screens/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:icon/screens/components/process_state.dart';
import 'package:icon/utils/extensions/extensions.dart';
import 'package:icon/utils/validator/auth_validators.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/widgets/normal_text_field.dart';
import 'package:icon/widgets/obscure_text_field.dart';
import 'package:icon/widgets/rounded_button.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? input) {
    if (input != null && AuthValidators.isValidEmail(input)) {
      return null;
    } else {
      return "Invalid email";
    }
  }

  String? _validatePassword(String? input) {
    if (input != null && AuthValidators.isValidPassword(input)) {
      return null;
    } else {
      return "Invalid password";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        final formStatus = state.submitForm;
        if (formStatus is ProcessFailure) {
          ExpandedSnackBar.showFailureSnackBar(
            context,
            formStatus.errorMessage,
          );
        }

        if (formStatus is Processing) {
          ExpandedSnackBar.showLoadingSnackBar(
            context,
            'Logging In...',
          );
        }

        if (formStatus is ProcessSuccess) {
          ExpandedSnackBar.showSuccessSnackBar(
            context,
            'Login Success',
          );
          Future.delayed(const Duration(milliseconds: 1000), () {
            Routes.pushNamed(RouteNames.verifyPin,
                navigator: Routes.signInNavigator);
          });
          // Future.delayed(const Duration(milliseconds: 2000), () {
          //   Navigator.of(context).popUntil((route) => route.isFirst);
          // });
        }
      },
      builder: (context, state) {
        final textTheme = Theme.of(context).textTheme;
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NormalTextField(
                  labelText: "Email address",
                  controller: _emailController,
                  // hintText: "Enter your email",
                  validator: _validateEmail,
                  onChange: (value) {
                    context.read<SignInBloc>().add(EmailOnChange(email: value));
                  },
                ),
                SizedBox(height: 10.h),
                ObscureTextField(
                  labelText: "Password",
                  controller: _passwordController,
                  // hintText: "Enter your password",
                  validator: _validatePassword,
                  onChange: (value) {
                    context
                        .read<SignInBloc>()
                        .add(PasswordOnChange(password: value));
                  },
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        Routes.pushNamed(RouteNames.forgotPassword,
                            navigator: Routes.signInNavigator);
                      },
                      child: Text(
                        "Forgot your password?",
                        style: textTheme.button,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                RoundedButton(
                  text: 'Login',
                  padding: EdgeInsets.symmetric(horizontal: 64.w),
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        state.submitForm is! Processing) {
                      context.read<SignInBloc>().add(SubmitLogin());
                    }
                  },
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an account? ", style: textTheme.bodyText2),
                    GestureDetector(
                      onTap: () {
                        Routes.pop();
                        Routes.pushNamed(RouteNames.signUp);
                      },
                      child: Text(
                        "Sign Up",
                        style: textTheme.button,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
