import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:icon/models/public_user_info.dart';
import 'package:icon/repositories/public_user_info_repository.dart';
import 'package:icon/repositories/user_repository.dart';
import 'package:icon/route/app_routes.dart';
import 'package:icon/route/subnavigator.dart';
import 'package:icon/screens/auth/home/home_screen.dart';
import 'package:icon/screens/auth/pin_login/pin_login_screen.dart';
import 'package:icon/screens/auth/welcome/welcome.dart';
import 'package:icon/screens/components/bloc/firestore/firestore_bloc.dart';
import 'package:icon/screens/section_cubit.dart';
import 'package:icon/widgets/loading_view.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SectionCubit, SectionState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Future.delayed(Duration(milliseconds: 500),
              () => Routes.pushReplacementNamed(RouteNames.main));
        }

        if (state is Unauthenticated) {
          Future.delayed(Duration(milliseconds: 500),
              () => Routes.pushReplacementNamed(RouteNames.auth));
        }
      },
      builder: (context, state) {
        return LoadingView();
      },
    );
  }
}
