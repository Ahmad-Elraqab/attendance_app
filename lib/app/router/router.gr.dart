// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:attendance_app/view/calendar_view/calendar_view.dart'
    deferred as _i1;
import 'package:attendance_app/view/clock_view/clock_view.dart' deferred as _i2;
import 'package:attendance_app/view/home_view/home_view.dart' deferred as _i3;
import 'package:attendance_app/view/login_view/login_view.dart' deferred as _i4;
import 'package:attendance_app/view/main_view.dart' deferred as _i5;
import 'package:attendance_app/view/money_view/money_view.dart' deferred as _i6;
import 'package:attendance_app/view/notification_view/notification_view.dart'
    deferred as _i7;
import 'package:attendance_app/view/signup_view/signup_view.dart'
    deferred as _i8;
import 'package:auto_route/auto_route.dart' as _i9;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    CalendarView.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.CalendarView(),
        ),
      );
    },
    ClockView.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.ClockView(),
        ),
      );
    },
    HomeView.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.HomeView(),
        ),
      );
    },
    LoginView.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.DeferredWidget(
          _i4.loadLibrary,
          () => _i4.LoginView(),
        ),
      );
    },
    MainView.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.DeferredWidget(
          _i5.loadLibrary,
          () => _i5.MainView(),
        ),
      );
    },
    MoneyView.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.DeferredWidget(
          _i6.loadLibrary,
          () => _i6.MoneyView(),
        ),
      );
    },
    NotificationView.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.DeferredWidget(
          _i7.loadLibrary,
          () => _i7.NotificationView(),
        ),
      );
    },
    SignUpView.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.DeferredWidget(
          _i8.loadLibrary,
          () => _i8.SignUpView(),
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.CalendarView]
class CalendarView extends _i9.PageRouteInfo<void> {
  const CalendarView({List<_i9.PageRouteInfo>? children})
      : super(
          CalendarView.name,
          initialChildren: children,
        );

  static const String name = 'CalendarView';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ClockView]
class ClockView extends _i9.PageRouteInfo<void> {
  const ClockView({List<_i9.PageRouteInfo>? children})
      : super(
          ClockView.name,
          initialChildren: children,
        );

  static const String name = 'ClockView';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomeView]
class HomeView extends _i9.PageRouteInfo<void> {
  const HomeView({List<_i9.PageRouteInfo>? children})
      : super(
          HomeView.name,
          initialChildren: children,
        );

  static const String name = 'HomeView';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginView]
class LoginView extends _i9.PageRouteInfo<void> {
  const LoginView({List<_i9.PageRouteInfo>? children})
      : super(
          LoginView.name,
          initialChildren: children,
        );

  static const String name = 'LoginView';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.MainView]
class MainView extends _i9.PageRouteInfo<void> {
  const MainView({List<_i9.PageRouteInfo>? children})
      : super(
          MainView.name,
          initialChildren: children,
        );

  static const String name = 'MainView';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.MoneyView]
class MoneyView extends _i9.PageRouteInfo<void> {
  const MoneyView({List<_i9.PageRouteInfo>? children})
      : super(
          MoneyView.name,
          initialChildren: children,
        );

  static const String name = 'MoneyView';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.NotificationView]
class NotificationView extends _i9.PageRouteInfo<void> {
  const NotificationView({List<_i9.PageRouteInfo>? children})
      : super(
          NotificationView.name,
          initialChildren: children,
        );

  static const String name = 'NotificationView';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SignUpView]
class SignUpView extends _i9.PageRouteInfo<void> {
  const SignUpView({List<_i9.PageRouteInfo>? children})
      : super(
          SignUpView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpView';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
