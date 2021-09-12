import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/route/app_routes.dart';
import 'package:icon/screens/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:icon/screens/components/process_state.dart';
import 'package:icon/utils/extensions/extensions.dart';
import 'package:icon/utils/extensions/pin_panel.dart';
import 'package:icon/widgets/custom_header.dart';

class ConfirmPinPage extends StatefulWidget {
  const ConfirmPinPage({Key? key}) : super(key: key);

  @override
  _ConfirmPinPageState createState() => _ConfirmPinPageState();
}

class _ConfirmPinPageState extends State<ConfirmPinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity),
            SizedBox(height: 50.h),
            CustomHeader(
              onPressedBack: () {
                Routes.pop(navigator: Routes.signUpNavigator);
              },
              title: "Confirm PIN",
              subtitle: "Repeat a PIN code to continue",
            ),
            SizedBox(height: 150.h),
            BlocConsumer<SignUpBloc, SignUpState>(
              listener: (context, state) {
                _handleStateListener(state);
              },
              builder: (context, state) {
                return PinPanel(
                  inititalValue: state.confirmPinStatus is Processing ? "" : "",
                  enable: state.confirmPinStatus is! Processing,
                  onFull: (value) {
                    context
                        .read<SignUpBloc>()
                        .add(ConfirmPinSubmit(pin: value));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleStateListener(SignUpState state) {
    final confirmPinStatus = state.confirmPinStatus;
    if (confirmPinStatus is ProcessFailure) {
      ExpandedSnackBar.showFailureSnackBar(
        context,
        confirmPinStatus.errorMessage,
      );
    }

    if (confirmPinStatus is ProcessSuccess) {
      ExpandedSnackBar.showSuccessSnackBar(
        context,
        "Confirm Pin Correct",
      );
      Future.delayed(
        Duration(milliseconds: 500),
        () => setState(() {
          context.read<SignUpBloc>().add(SignUpSubmit());
        }),
      );
    }

    final createAccountStatus = state.createAccountStatus;
    if (createAccountStatus is ProcessFailure) {
      ExpandedSnackBar.showFailureSnackBar(
        context,
        createAccountStatus.errorMessage,
      );
    }

    if (createAccountStatus is Processing) {
      ExpandedSnackBar.showLoadingSnackBar(
        context,
        'Signing Up...',
      );
    }

    if (createAccountStatus is ProcessSuccess) {
      ExpandedSnackBar.showSuccessSnackBar(
        context,
        'Sign Up Successfully!',
      );
      Routes.pop();
    }
  }
}
