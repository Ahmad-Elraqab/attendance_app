import 'package:attendance_app/app/app_view_models/app_view_model.dart';
import 'package:attendance_app/app/data_sources/local_storage/auth_token_secure_storage.dart';
import 'package:attendance_app/app/data_sources/local_storage/auth_token_shared_prefs.dart';
import 'package:attendance_app/app/data_sources/local_storage/auth_token_storage.dart';
import 'package:attendance_app/app/data_sources/remote/rest_service.dart';
import 'package:attendance_app/app/data_sources/shared_preferences_wrapper.dart';
import 'package:attendance_app/app/env/env.dart';
import 'package:attendance_app/services/attendance_service.dart';
import 'package:attendance_app/services/leave_service.dart';
import 'package:attendance_app/services/salary_service.dart';
import 'package:attendance_app/services/user_service.dart';
import 'package:attendance_app/view_models/attendance_viewmodel.dart';
import 'package:attendance_app/view_models/leave_viewmodel.dart';
import 'package:attendance_app/view_models/salary_viewmodel.dart';
import 'package:attendance_app/view_models/user_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppDependencies {
  AppDependencies._({
    required this.context,
    required this.env,
  });

  final BuildContext context;
  final EnvironmentConfig env;

  static AppDependencies? _instance;

  factory AppDependencies.of(context, env) =>
      _instance ?? AppDependencies._(context: context, env: env);

  List<SingleChildWidget> get providers => [
        ..._dataStorages,
        ..._dataSources,
        ..._analytics,
        ..._httpClients,
        ..._repositories,
        ..._useCases,
        ..._providers,
        ..._interceptors,
      ];

  List<ChangeNotifierProvider> get _providers => [
        ChangeNotifierProvider<AppViewModel>(
          create: (context) => AppViewModel(),
        ),
        ChangeNotifierProvider<UserViewModel>(
          create: (context) => UserViewModel(
            service: context.read(),
          ),
        ),
        ChangeNotifierProvider<LeaveViewmodel>(
          create: (context) => LeaveViewmodel(
            service: context.read(),
          ),
        ),
        ChangeNotifierProvider<AttendanceViewmodel>(
          create: (context) => AttendanceViewmodel(
            service: context.read(),
          ),
        ),
        ChangeNotifierProvider<SalaryViewmodel>(
          create: (context) => SalaryViewmodel(
            service: context.read(),
          ),
        ),
      ];
  List<Provider> get _analytics => [];
  List<Provider> get _httpClients => [
        Provider<Dio>(create: (context) => Dio()),
        Provider<RestService>(
          create: (context) => RestService(baseUrl: env.baseApiUrl),
        ),
        Provider<UserService>(
          create: (context) => UserService(
            localStorage: context.read(),
            sharedPreferences: context.read(),
            restService: context.read(),
            storage: context.read(),
          ),
        ),
        Provider<LeaveService>(
          create: (context) => LeaveService(
            localStorage: context.read(),
            restService: context.read(),
          ),
        ),
        Provider<AttendanceService>(
          create: (context) => AttendanceService(
            localStorage: context.read(),
            restService: context.read(),
          ),
        ),
        Provider<SalaryService>(
          create: (context) => SalaryService(
            localStorage: context.read(),
            restService: context.read(),
          ),
        ),
      ];
  List<Provider> get _dataStorages => [
        // Provider<CacheClient>(create: (context) => CacheClient()),
        Provider<SharedPreferencesWrapper>(
            create: (context) => SharedPreferencesWrapper()),

        Provider<FlutterSecureStorage>(
          create: (context) => const FlutterSecureStorage(),
        ),
      ];
  List<Provider> get _dataSources => [
        Provider<AuthTokenStorage>(
          create: (context) => kIsWeb
              ? AuthTokenSharedPrefs(context.read<SharedPreferencesWrapper>())
              : AuthTokenSecureStorage(context.read<FlutterSecureStorage>()),
        ),
      ];
  List<Provider> get _repositories => [];
  List<Provider> get _useCases => [];
  List<Provider> get _interceptors => [];
}
