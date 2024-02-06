import 'package:attendance_app/app/data_sources/remote/custom_dio_error.dart';
import 'package:attendance_app/models/leave_model.dart';
import 'package:attendance_app/models/leave_type_model.dart';
import 'package:attendance_app/services/leave_service.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart' as dt;

class LeaveViewmodel extends ChangeNotifier {
  LeaveViewmodel({required this.service});

  LeaveService service;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    Future.microtask(() => notifyListeners());
  }

  List<LeaveModel>? userLeaves;
  List<LeaveModel>? approverLeaves;
  List<LeaveModel>? hrLeaves;

  List<LeaveTypeModel>? leaveTypes;

  Future<void> getLeaves({
    required Function onError,
    required Function onSuccess,
  }) async {
    try {
      loading = true;

      var leaveData = await service.getLeaves();

      userLeaves = leaveData.$1;
      approverLeaves = leaveData.$2;
      hrLeaves = leaveData.$3;

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

  Future<void> getLeaveTypes({
    required Function onError,
    required Function onSuccess,
  }) async {
    try {
      loading = true;

      leaveTypes = await service.getLeaveTypes();

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

  Future<void> createLeave({
    required DateTime startDate,
    required DateTime endDate,
    required String type,
    required Function onError,
    required Function onSuccess,
  }) async {
    try {
      loading = true;

      var responseMsg = await service.createLeave(
        endDate: dt.DateFormat("dd-MM-yyyy").format(endDate).toString(),
        startDate: dt.DateFormat("dd-MM-yyyy").format(startDate).toString(),
        type: type,
      );

      loading = false;

      onSuccess(responseMsg);
    } catch (e) {
      loading = false;
      if (e is RestException) {
        onError(e.responseMessage);
      } else {
        onError("something went wrong!");
      }
    }
  }
}
