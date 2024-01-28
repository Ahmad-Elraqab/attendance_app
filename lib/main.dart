import 'package:attendance_app/app/app.dart';
import 'package:attendance_app/app/env/env.dart';
import 'package:flutter/material.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    App(env: EnvironmentConfig.prod),
  );
}
