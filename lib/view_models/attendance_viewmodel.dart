import 'package:attendance_app/app/data_sources/remote/custom_dio_error.dart';
import 'package:attendance_app/models/attendance_status_model.dart';
import 'package:attendance_app/services/attendance_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AttendanceViewmodel extends ChangeNotifier {
  AttendanceViewmodel({required this.service});

  AttendanceService service;

  bool _loading = false;
  bool _checkLoading = false;
  bool _isFirstTime = false;

  bool get isFirstTime => _isFirstTime;

  set isFirstTime(bool value) {
    _isFirstTime = value;
  }

  bool get checkLoading => _checkLoading;

  set checkLoading(bool value) {
    _checkLoading = value;
    Future.microtask(() => notifyListeners());
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    Future.microtask(() => notifyListeners());
  }

  AttendanceStatusModel? statusModel;

  Future<void> checkIn({
    required Function onError,
    required Function onSuccess,
    required String deviceId,
    required AttendanceLogType logType,
  }) async {
    try {
      checkLoading = true;

      final Position? location = await fetchLocation();
      if (location == null) {
        throw "no location access";
      } else {
        final response = await service.checkIn(
          location.latitude,
          location.longitude,
          deviceId,
          logType.name.toUpperCase(),
        );

        onSuccess(response);
      }

      checkLoading = false;
    } catch (e) {
      checkLoading = false;
      if (e is RestException) {
        onError(e.responseMessage);
      } else {
        onError("something went wrong!");
      }
    }
  }

  Future<AttendanceLogType?> getCheckStatus({
    required Function onError,
    required Function onSuccess,
    willLoad = true,
  }) async {
    try {
      if (willLoad) {
        loading = true;
      }

      final response = await service.getLastCheck();

      statusModel = response;

      onSuccess(response);

      loading = false;

      return statusModel!.logType!;
    } catch (e) {
      loading = false;
      if (e is RestException) {
        onError(e.responseMessage);
      } else {
        if (e == 'firstTime') {
          // print('firstTime');
          isFirstTime = true;
          statusModel = AttendanceStatusModel(
            logType: AttendanceLogType.OUT,
            time: DateTime.now(),
          );
        }
        onError("something went wrong!");
      }
      return null;
    }
  }

  Future<Position?> fetchLocation() async {
    try {
      Position? currentLocation;
      if (await Geolocator.checkPermission() == LocationPermission.whileInUse) {
        currentLocation = await Geolocator.getCurrentPosition();
      } else {
        await Geolocator.requestPermission().then((value) async {
          currentLocation = await Geolocator.getCurrentPosition();
        });
      }
      return currentLocation!;
    } catch (e) {
      return null;
    }
  }
}
