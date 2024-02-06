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
import 'package:attendance_app/view/details_notification_view/details_notification_view.dart'
    deferred as _i10;
import 'package:attendance_app/view/home_view/home_view.dart' deferred as _i3;
import 'package:attendance_app/view/leave_application_view/leave_application_view.dart'
    deferred as _i4;
import 'package:attendance_app/view/leaves_view/leaves_view.dart'
    deferred as _i5;
import 'package:attendance_app/view/login_view/login_view.dart' deferred as _i6;
import 'package:attendance_app/view/main_view.dart' deferred as _i7;
import 'package:attendance_app/view/mobile_verification_view/mobile_verification_view.dart'
    deferred as _i8;
import 'package:attendance_app/view/money_view/money_view.dart' deferred as _i9;
import 'package:attendance_app/view/notification_view/notification_view.dart'
    deferred as _i11;
import 'package:attendance_app/view/otp_view/otp_view.dart' deferred as _i12;
import 'package:attendance_app/view/profile_view/profile_view.dart'
    deferred as _i13;
import 'package:attendance_app/view/signup_view/signup_view.dart'
    deferred as _i14;
import 'package:auto_route/auto_route.dart' as _i15;

abstract class $AppRouter extends _i15.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    CalendarView.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.CalendarView(),
        ),
      );
    },
    ClockView.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.ClockView(),
        ),
      );
    },
    HomeView.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.HomeView(),
        ),
      );
    },
    LeaveApplicationView.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.DeferredWidget(
          _i4.loadLibrary,
          () => _i4.LeaveApplicationView(),
        ),
      );
    },
    LeavesView.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.DeferredWidget(
          _i5.loadLibrary,
          () => _i5.LeavesView(),
        ),
      );
    },
    LoginView.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.DeferredWidget(
          _i6.loadLibrary,
          () => _i6.LoginView(),
        ),
      );
    },
    MainView.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.DeferredWidget(
          _i7.loadLibrary,
          () => _i7.MainView(),
        ),
      );
    },
    MobileVerificationView.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.DeferredWidget(
          _i8.loadLibrary,
          () => _i8.MobileVerificationView(),
        ),
      );
    },
    MoneyView.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.DeferredWidget(
          _i9.loadLibrary,
          () => _i9.MoneyView(),
        ),
      );
    },
    NotificationDetailsView.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.DeferredWidget(
          _i10.loadLibrary,
          () => _i10.NotificationDetailsView(),
        ),
      );
    },
    NotificationView.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.DeferredWidget(
          _i11.loadLibrary,
          () => _i11.NotificationView(),
        ),
      );
    },
    OtpView.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.DeferredWidget(
          _i12.loadLibrary,
          () => _i12.OtpView(),
        ),
      );
    },
    ProfileDetailsView.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.DeferredWidget(
          _i13.loadLibrary,
          () => _i13.ProfileDetailsView(),
        ),
      );
    },
    SignUpView.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.DeferredWidget(
          _i14.loadLibrary,
          () => _i14.SignUpView(),
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.CalendarView]
class CalendarView extends _i15.PageRouteInfo<void> {
  const CalendarView({List<_i15.PageRouteInfo>? children})
      : super(
          CalendarView.name,
          initialChildren: children,
        );

  static const String name = 'CalendarView';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ClockView]
class ClockView extends _i15.PageRouteInfo<void> {
  const ClockView({List<_i15.PageRouteInfo>? children})
      : super(
          ClockView.name,
          initialChildren: children,
        );

  static const String name = 'ClockView';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomeView]
class HomeView extends _i15.PageRouteInfo<void> {
  const HomeView({List<_i15.PageRouteInfo>? children})
      : super(
          HomeView.name,
          initialChildren: children,
        );

  static const String name = 'HomeView';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LeaveApplicationView]
class LeaveApplicationView extends _i15.PageRouteInfo<void> {
  const LeaveApplicationView({List<_i15.PageRouteInfo>? children})
      : super(
          LeaveApplicationView.name,
          initialChildren: children,
        );

  static const String name = 'LeaveApplicationView';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LeavesView]
class LeavesView extends _i15.PageRouteInfo<void> {
  const LeavesView({List<_i15.PageRouteInfo>? children})
      : super(
          LeavesView.name,
          initialChildren: children,
        );

  static const String name = 'LeavesView';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i6.LoginView]
class LoginView extends _i15.PageRouteInfo<void> {
  const LoginView({List<_i15.PageRouteInfo>? children})
      : super(
          LoginView.name,
          initialChildren: children,
        );

  static const String name = 'LoginView';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i7.MainView]
class MainView extends _i15.PageRouteInfo<void> {
  const MainView({List<_i15.PageRouteInfo>? children})
      : super(
          MainView.name,
          initialChildren: children,
        );

  static const String name = 'MainView';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i8.MobileVerificationView]
class MobileVerificationView extends _i15.PageRouteInfo<void> {
  const MobileVerificationView({List<_i15.PageRouteInfo>? children})
      : super(
          MobileVerificationView.name,
          initialChildren: children,
        );

  static const String name = 'MobileVerificationView';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i9.MoneyView]
class MoneyView extends _i15.PageRouteInfo<void> {
  const MoneyView({List<_i15.PageRouteInfo>? children})
      : super(
          MoneyView.name,
          initialChildren: children,
        );

  static const String name = 'MoneyView';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i10.NotificationDetailsView]
class NotificationDetailsView extends _i15.PageRouteInfo<void> {
  const NotificationDetailsView({List<_i15.PageRouteInfo>? children})
      : super(
          NotificationDetailsView.name,
          initialChildren: children,
        );

  static const String name = 'NotificationDetailsView';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i11.NotificationView]
class NotificationView extends _i15.PageRouteInfo<void> {
  const NotificationView({List<_i15.PageRouteInfo>? children})
      : super(
          NotificationView.name,
          initialChildren: children,
        );

  static const String name = 'NotificationView';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i12.OtpView]
class OtpView extends _i15.PageRouteInfo<void> {
  const OtpView({List<_i15.PageRouteInfo>? children})
      : super(
          OtpView.name,
          initialChildren: children,
        );

  static const String name = 'OtpView';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i13.ProfileDetailsView]
class ProfileDetailsView extends _i15.PageRouteInfo<void> {
  const ProfileDetailsView({List<_i15.PageRouteInfo>? children})
      : super(
          ProfileDetailsView.name,
          initialChildren: children,
        );

  static const String name = 'ProfileDetailsView';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i14.SignUpView]
class SignUpView extends _i15.PageRouteInfo<void> {
  const SignUpView({List<_i15.PageRouteInfo>? children})
      : super(
          SignUpView.name,
          initialChildren: children,
        );

  static const String name = 'SignUpView';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}
