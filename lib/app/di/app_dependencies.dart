import 'package:attendance_app/app/app_view_models/app_view_model.dart';
import 'package:attendance_app/app/env/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        )
      ];
  List<Provider> get _analytics => [];
  List<Provider> get _httpClients => [
        // Provider<Dio>(create: (context) => Dio()),
        // Provider<RestService>(
        //   create: (context) => RestService(
        //     baseUrl: env.baseApiUrl,
        //   ),
        // ),
      ];
  List<Provider> get _dataStorages => [];
  List<Provider> get _dataSources => [];
  List<Provider> get _repositories => [];
  List<Provider> get _useCases => [];
  List<Provider> get _interceptors => [];
}
