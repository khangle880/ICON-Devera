import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_routes.dart';

class SubNavigator extends StatelessWidget {
  const SubNavigator({
    required this.navigatorKey,
    required this.initialRoute,
    Key? key,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    final _SubNavigatorObserver _navigatorObserver = _SubNavigatorObserver(
      initialRoute,
      navigatorKey,
    );
    Routes.currentSubNavigatorInitialRoute = initialRoute;

    return WillPopScope(
      onWillPop: () async {
        if (_navigatorObserver.isInitialPage) {
          Routes.currentSubNavigatorInitialRoute = null;
          await SystemNavigator.pop();
          return true;
        }

        final bool canPop = navigatorKey.currentState!.canPop();

        if (canPop) {
          navigatorKey.currentState!.pop();
        }

        return !canPop;
      },
      child: Navigator(
        key: navigatorKey,
        observers: <NavigatorObserver>[_navigatorObserver],
        initialRoute: initialRoute,
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    );
  }
}

//--------------------------------------------------------------------------------
/// [NavigatorObserver] of [SubNavigator] widget.
///
///
class _SubNavigatorObserver extends NavigatorObserver {
  _SubNavigatorObserver(this._initialRoute, this._navigatorKey);

  final String _initialRoute;
  final GlobalKey<NavigatorState> _navigatorKey;
  final List<String> _routeNameStack = <String>[];

  bool _isInitialPage = false;

  /// Flag if current route is the initial page.
  ///
  ///
  bool get isInitialPage => _isInitialPage;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeNameStack.add(route.settings.name!);
    _isInitialPage = _routeNameStack.last == _initialRoute;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeNameStack.remove(route.settings.name);
    _isInitialPage = _routeNameStack.last == _initialRoute;
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeNameStack.remove(route.settings.name);
    _isInitialPage = _routeNameStack.last == _initialRoute;
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (oldRoute != null && newRoute != null) {
      _routeNameStack.remove(oldRoute.settings.name);
      _routeNameStack.add(newRoute.settings.name!);
      _isInitialPage = _routeNameStack.last == _initialRoute;
    }
  }
}
