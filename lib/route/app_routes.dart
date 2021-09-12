import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon/models/public_user_info.dart';
import 'package:icon/repositories/public_user_info_repository.dart';
import 'package:icon/repositories/user_repository.dart';
import 'package:icon/route/subnavigator.dart';
import 'package:icon/screens/auth/check_email/check_email_screen.dart';
import 'package:icon/screens/auth/confirm_pin/confirm_pin_screen.dart';
import 'package:icon/screens/auth/create_new_password/create_new_pass_screen.dart';
import 'package:icon/screens/auth/create_pin/create_pin_screen.dart';
import 'package:icon/screens/auth/forgot_password/bloc/reset_password_bloc.dart';
import 'package:icon/screens/auth/forgot_password/forgot_password_page.dart';
import 'package:icon/screens/auth/home/home_screen.dart';
import 'package:icon/screens/auth/pin_login/pin_login_screen.dart';
import 'package:icon/screens/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:icon/screens/auth/sign_in/sign_in_view.dart';
import 'package:icon/screens/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:icon/screens/auth/sign_up/sign_up_screen.dart';
import 'package:icon/screens/auth/verify_pin/verify_pin_screen.dart';
import 'package:icon/screens/auth/welcome/welcome.dart';
import 'package:icon/screens/components/bloc/firestore/firestore_bloc.dart';
import 'package:icon/screens/section_cubit.dart';
import 'package:icon/screens/wrapper/wrapper.dart';
import 'package:icon/widgets/loading_view.dart';

class RouteNames {
  static const String initial = "/";
  static const String auth = "/welcome";
  static const String login = "/login";
  static const String loginHome = "/login-home";
  static const String signUp = "/sign-up";
  static const String signUpHome = "/sign-up-home";
  static const String verifyPin = "/verify-pin";
  static const String forgotPassword = "/forgot-password";
  static const String forgotPasswordHome = "/forgot-password-home";
  static const String checkEmail = "/checkEmail";
  static const String createNewPassword = "/create-new-password";
  static const String createPin = "/create-pin";
  static const String createPinConfirm = "/create-pin-confirm";
  static const String main = "/main";
  static const String pinLogin = "/pin-login";
  static const String home = "/home";
}

class Routes {
  Routes._();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> signInNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> forgotPasswordNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> signUpNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> mainNavigatorKey =
      GlobalKey<NavigatorState>();

  static String? currentSubNavigatorInitialRoute;

  static CupertinoPageRoute<Widget>? onGenerateRoute(RouteSettings settings) {
    late Widget page;

    switch (settings.name) {
      case RouteNames.initial:
        page = Wrapper();
        break;
      case RouteNames.auth:
        page = WelcomeScreen();
        break;
      case RouteNames.login:
        page = BlocProvider(
          create: (context) => SignInBloc(
              userRepository: context.read<UserRepository>(),
              sectionCubit: context.read<SectionCubit>()),
          child: SubNavigator(
            navigatorKey: signInNavigatorKey,
            initialRoute: RouteNames.loginHome,
          ),
        );
        break;
      case RouteNames.loginHome:
        page = SignInPage();
        break;
      case RouteNames.verifyPin:
        page = VerifyPinPage();
        break;
      case RouteNames.forgotPassword:
        page = BlocProvider<ResetPasswordBloc>(
          create: (context) =>
              ResetPasswordBloc(userRepository: context.read<UserRepository>()),
          child: SubNavigator(
            navigatorKey: forgotPasswordNavigatorKey,
            initialRoute: RouteNames.forgotPasswordHome,
          ),
        );
        break;
      case RouteNames.forgotPasswordHome:
        page = ForgotPasswordPage();
        break;
      case RouteNames.checkEmail:
        page = CheckEmailPage();
        break;
      case RouteNames.createNewPassword:
        page = CreateNewPasswordPage();
        break;
      case RouteNames.signUp:
        page = BlocProvider(
          create: (context) => SignUpBloc(
              userRepository: context.read<UserRepository>(),
              sectionCubit: context.read<SectionCubit>()),
          child: SubNavigator(
            navigatorKey: signUpNavigatorKey,
            initialRoute: RouteNames.signUpHome,
          ),
        );
        break;
      case RouteNames.signUpHome:
        page = SignUpPage();
        break;
      case RouteNames.createPin:
        page = CreatePinPage();
        break;
      case RouteNames.createPinConfirm:
        page = ConfirmPinPage();
        break;
      case RouteNames.main:
        page = BlocProvider(
          create: (context) => FirestoreBloc<PublicInfo>(
              context.read<PublicInfoRepository>())
            ..add(LoadFirestore(context.read<UserRepository>().getUser()!.uid)),
          child: SubNavigator(
            navigatorKey: Routes.mainNavigatorKey,
            initialRoute: RouteNames.pinLogin,
          ),
        );
        break;
      case RouteNames.pinLogin:
        page = PinLoginPage();
        break;
      case RouteNames.home:
        page = HomePage();
        break;
    }

    if (settings.name == RouteNames.initial &&
        currentSubNavigatorInitialRoute != null) {
      // When current sub-navigator initial route is set,
      // do not display initial route because it is already displayed.
      return null;
    }

    return CupertinoPageRoute<Widget>(
      builder: (_) {
        if (currentSubNavigatorInitialRoute == settings.name) {
          return WillPopScope(
            onWillPop: () async => false,
            child: page,
          );
        }

        return page;
      },
      settings: settings,
    );
  }

  /// [MaterialApp] navigator key.
  ///
  ///
  static NavigatorState? get rootNavigator => rootNavigatorKey.currentState;

  /// [SIGN_IN] navigator key.
  ///
  ///
  static NavigatorState? get signInNavigator => signInNavigatorKey.currentState;

  /// [SIGN_UP] navigator key.
  ///
  ///
  static NavigatorState? get signUpNavigator => signUpNavigatorKey.currentState;

  /// [FORGOT_PASSWORD] navigator key.
  ///
  ///
  static NavigatorState? get forgotPassNavigator =>
      forgotPasswordNavigatorKey.currentState;

  /// [HOME] navigator key.
  ///
  ///
  static NavigatorState? get mainNavigator => mainNavigatorKey.currentState;

  /// Navigate to screen via [CupertinoPageRoute].
  ///
  /// If [navigator] is not set, it will use the [rootNavigator].
  static void push(Widget screen, {NavigatorState? navigator}) {
    final CupertinoPageRoute<Widget> route = CupertinoPageRoute<Widget>(
      builder: (_) => screen,
    );

    if (navigator != null) {
      navigator.push(route);
      return;
    }

    rootNavigator!.push(route);
  }

  /// Navigate to route name via [CupertinoPageRoute].
  ///
  /// If [navigator] is not set, it will use the [rootNavigator].
  static void pushNamed(
    String routeName, {
    NavigatorState? navigator,
    Object? arguments,
  }) {
    if (navigator != null) {
      log(navigator.toString());
      navigator.pushNamed(routeName, arguments: arguments);
      return;
    }

    rootNavigator!.pushNamed(routeName, arguments: arguments);
  }

  static void pushReplacementNamed(
    String routeName, {
    NavigatorState? navigator,
    Object? arguments,
  }) {
    if (navigator != null) {
      log(navigator.toString());
      navigator.pushReplacementNamed(routeName, arguments: arguments);
      return;
    }

    rootNavigator!.pushNamed(routeName, arguments: arguments);
  }

  /// Pop current route of [navigator].
  ///
  /// If [navigator] is not set, it will use the [rootNavigator].
  static void pop<T extends Object>({
    NavigatorState? navigator,
    T? result,
  }) {
    if (navigator != null) {
      navigator.pop(result);
      return;
    }

    rootNavigator!.pop(result);
  }
}
