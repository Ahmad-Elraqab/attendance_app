// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:attendance_app/view/main_view.dart' deferred as _i1;
import 'package:auto_route/auto_route.dart' as _i2;

abstract class $AppRouter extends _i2.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    MainView.name: (routeData) {
      return _i2.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.MainView(),
        ),
      );
    }
  };
}

/// generated route for
/// [_i1.MainView]
class MainView extends _i2.PageRouteInfo<void> {
  const MainView({List<_i2.PageRouteInfo>? children})
      : super(
          MainView.name,
          initialChildren: children,
        );

  static const String name = 'MainView';

  static const _i2.PageInfo<void> page = _i2.PageInfo<void>(name);
}
