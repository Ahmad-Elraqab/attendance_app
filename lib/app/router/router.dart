// For every changes made in router, run the below command:
// `flutter pub run build_runner build --delete-conflicting-outputs`

import 'package:attendance_app/app/router/router.gr.dart';
import 'package:attendance_app/app/router/user_guard.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(
  deferredLoading: true,
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: OtpView.page,
          path: '/otp',
        ),
        AutoRoute(
          page: MobileVerificationView.page,
          path: '/MobileVerification',
        ),
        AutoRoute(
          page: LeaveApplicationView.page,
          path: '/leaveApplication',
        ),
        AutoRoute(
          page: ProfileDetailsView.page,
          path: '/profile',
        ),
        AutoRoute(
          page: NotificationDetailsView.page,
          path: '/notificationDetails',
        ),
        AutoRoute(
          page: LoginView.page,
          path: '/login',
        ),
        AutoRoute(
          page: LeavesView.page,
          path: '/leaves',
        ),
        AutoRoute(
          page: SignUpView.page,
          path: '/signUp',
        ),
        AutoRoute(
          initial: true,
          guards: [
            AuthGuard.init(),
          ],
          page: MainView.page,
          path: '/',
          children: [
            AutoRoute(
              initial: true,
              page: HomeView.page,
              path: 'home',
              maintainState: false,
            ),
            AutoRoute(
              page: ClockView.page,
              path: 'clock',
              maintainState: false,
            ),
            AutoRoute(
              page: CalendarView.page,
              path: 'calendar',
              maintainState: false,
            ),
            AutoRoute(
              page: MoneyView.page,
              path: 'money',
              maintainState: false,
            ),
            AutoRoute(
              page: NotificationView.page,
              path: 'notification',
              maintainState: false,
            ),
          ],
        ),
      ];
}
