// For every changes made in router, run the below command:
// `flutter pub run build_runner build --delete-conflicting-outputs`

import 'package:attendance_app/app/router/router.gr.dart';
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
          initial: true,
          page: MainView.page,
          path: '/',
          children: [
            AutoRoute(
              initial: true,
              page: MainView.page,
              path: 'home',
            ),
            AutoRoute(
              page: MainView.page,
              path: 'clock',
            ),
            AutoRoute(
              page: MainView.page,
              path: 'calendar',
            ),
            AutoRoute(
              page: MainView.page,
              path: 'money',
            ),
            AutoRoute(
              page: MainView.page,
              path: 'notification',
            ),
          ],
        ),
      ];
}
