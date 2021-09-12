import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/route/app_routes.dart';
import 'package:icon/screens/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:icon/screens/components/process_state.dart';
import 'package:icon/screens/section_cubit.dart';
import 'package:icon/utils/extensions/extensions.dart';
import 'package:icon/utils/extensions/pin_panel.dart';
import 'package:icon/widgets/custom_header.dart';

class VerifyPinPage extends StatefulWidget {
  const VerifyPinPage({Key? key}) : super(key: key);

  @override
  _VerifyPinPageState createState() => _VerifyPinPageState();
}

class _VerifyPinPageState extends State<VerifyPinPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                Routes.pop(navigator: Routes.signInNavigator);
                context.read<SectionCubit>().signOut();
              },
              title: "Verification Required",
              subtitle: "Please enter your PIN to proceed",
            ),
            SizedBox(height: 150.h),
            BlocConsumer<SignInBloc, SignInState>(
              listener: (context, state) {
                final verifyStatus = state.verifyStatus;
                if (verifyStatus is ProcessFailure) {
                  ExpandedSnackBar.showFailureSnackBar(
                    context,
                    verifyStatus.errorMessage,
                  );
                }

                if (verifyStatus is Processing) {
                  ExpandedSnackBar.showLoadingSnackBar(
                    context,
                    'Logging In...',
                  );
                }

                if (verifyStatus is ProcessSuccess) {
                  // Navigator.of(context).popUntil((route) => route.isFirst);
                  ExpandedSnackBar.showSuccessSnackBar(
                    context,
                    'Login Success',
                  );
                  // Routes.pop(navigator: Routes.signInNavigator);
                  Routes.pop();
                }
              },
              builder: (context, state) {
                return PinPanel(
                  inititalValue: state.submitForm is Processing ? "" : "",
                  enable: state.submitForm is! Processing,
                  onFull: (value) {
                    context.read<SignInBloc>().add(PinVerify(pin: value));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
