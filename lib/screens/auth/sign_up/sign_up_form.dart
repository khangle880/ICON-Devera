import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon/route/app_routes.dart';
import 'package:icon/screens/components/process_state.dart';
import 'package:icon/utils/extensions/extensions.dart';
import 'package:icon/utils/validator/auth_validators.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/widgets/normal_text_field.dart';
import 'package:icon/widgets/obscure_text_field.dart';
import 'package:icon/widgets/rounded_button.dart';

import 'bloc/sign_up_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

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
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        
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
                  labelText: "First Name",
                  textCapitalization: TextCapitalization.sentences,
                  onChange: (value) {
                    context
                        .read<SignUpBloc>()
                        .add(FirstNameOnChange(firstName: value));
                  },
                ),
                SizedBox(height: 10.h),
                NormalTextField(
                  labelText: "Last Name",
                  textCapitalization: TextCapitalization.sentences,
                  onChange: (value) {
                    context
                        .read<SignUpBloc>()
                        .add(LastNameOnChange(lastName: value));
                  },
                ),
                SizedBox(height: 10.h),
                NormalTextField(
                  labelText: "Email address",
                  validator: _validateEmail,
                  onChange: (value) {
                    context.read<SignUpBloc>().add(EmailOnChange(email: value));
                  },
                ),
                SizedBox(height: 10.h),
                ObscureTextField(
                  labelText: "Password",
                  validator: _validatePassword,
                  onChange: (value) {
                    context
                        .read<SignUpBloc>()
                        .add(PasswordOnChange(password: value));
                  },
                ),
                SizedBox(height: 10.h),
                Spacer(),
                RoundedButton(
                  text: 'Let’s Get Started',
                  padding: EdgeInsets.symmetric(horizontal: 64.w),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                     Routes.pushNamed(RouteNames.createPin,
                        navigator: Routes.signUpNavigator);
                    }
                  },
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ",
                        style: textTheme.bodyText2),
                    GestureDetector(
                      onTap: () {
                        Routes.pop();
                        Routes.pushNamed(RouteNames.login);
                      },
                      child: Text(
                        "Login",
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
