import 'package:attendance_app/app/data_sources/remote/custom_dio_error.dart';
import 'package:attendance_app/services/attendance_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AttendanceViewmodel extends ChangeNotifier {
  AttendanceViewmodel({required this.service});

  AttendanceService service;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    Future.microtask(() => notifyListeners());
  }

  Future<void> checkIn({
    required Function onError,
    required Function onSuccess,
  }) async {
    try {
      loading = true;

      final Position? location = await fetchLocation();
      if (location == null) {
        throw "no location access";
      } else {
        await service.checkIn(location.latitude, location.longitude);
      }

      loading = false;
    } catch (e) {
      loading = false;
      if (e is RestException) {
        onError(e.responseMessage);
      } else {
        onError("something went wrong!");
      }
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
