import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/route/app_routes.dart';
import 'package:icon/screens/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:icon/screens/section_cubit.dart';
import 'package:icon/utils/extensions/pin_panel.dart';
import 'package:icon/widgets/custom_header.dart';

class CreatePinPage extends StatefulWidget {
  const CreatePinPage({Key? key}) : super(key: key);

  @override
  _CreatePinPageState createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
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
                context.read<SectionCubit>().signOut();
              },
              title: "Create a PIN",
              subtitle:
                  "Enhance the security of your account by creating a PIN code",
            ),
            SizedBox(height: 150.h),
            BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                return PinPanel(
                  inititalValue: "",
                  enable: true,
                  onFull: (value) {
                    context.read<SignUpBloc>().add(CreatePinSubmit(pin: value));
                    Routes.pushNamed(RouteNames.createPinConfirm,
                        navigator: Routes.signUpNavigator);
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
