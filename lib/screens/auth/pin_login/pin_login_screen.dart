import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/global/constants/app_constants.dart';
import 'package:icon/models/public_user_info.dart';
import 'package:icon/repositories/user_repository.dart';
import 'package:icon/route/app_routes.dart';
import 'package:icon/screens/components/bloc/firestore/firestore_bloc.dart';
import 'package:icon/utils/errors/auth_error.dart';
import 'package:icon/utils/extensions/pin_panel.dart';
import 'package:icon/utils/extensions/extensions.dart';
import 'package:icon/widgets/loading_view.dart';

class PinLoginPage extends StatefulWidget {
  const PinLoginPage({Key? key}) : super(key: key);

  @override
  _PinLoginPageState createState() => _PinLoginPageState();
}

class _PinLoginPageState extends State<PinLoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirestoreBloc<PublicInfo>, FirestoreState<PublicInfo>>(
      builder: (context, state) {
        if (state is FirestoreLoaded<PublicInfo>) {
          final info = context
              .read<FirestoreBloc<PublicInfo>>()
              .allDoc
              .findById(context.read<UserRepository>().getUser()!.uid);
          if (info == null) {
            return Scaffold(
              body: Center(
                child: Text(
                  'Not exist user!',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            );
          }

          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: double.infinity),
                  SizedBox(height: 50.h),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Hi, ${info.firstName} ${info.lastName}",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: ColorConstants.kSecondaryColor),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "Please enter your PIN to proceed",
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 150.h),
                  PinPanel(
                    inititalValue: "",
                    enable: true,
                    onFull: (value) async {
                      final error =
                          await context.read<UserRepository>().verifyPin(value);
                      if (error != null) {
                        // ignore: use_build_context_synchronously
                        ExpandedSnackBar.showFailureSnackBar(
                          context,
                          authErrors[error] ?? error,
                        );
                      } else {
                        Future.delayed(Duration(milliseconds: 500), () {
                          Routes.pushNamed(RouteNames.home,
                              navigator: Routes.mainNavigator);
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return LoadingView();
        }
      },
    );
  }
}
