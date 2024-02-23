import 'package:attendance_app/models/salary_details_model.dart';
import 'package:attendance_app/models/salary_model.dart';
import 'package:attendance_app/services/salary_service.dart';
import 'package:flutter/material.dart';

class SalaryViewmodel extends ChangeNotifier {
  SalaryViewmodel({required this.service});

  SalaryService service;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    Future.microtask(() => notifyListeners());
  }

  List<SalaryModel>? salaries;
  SalaryDetailsModel? salaryDetails;

  Future<void> getSalaries({
    required Function onError,
    required Function onSuccess,
  }) async {
    loading = false;
    try {
      loading = true;

      salaries = await service.getSalaries();

      // loading = false;
    } catch (e) {
      loading = false;
      onError("something went wrong!");
    }
  }

  Future<void> getSalaryDetails({
    required String id,
    required Function onError,
    required Function onSuccess,
  }) async {
    loading = false;
    try {
      loading = true;

      salaryDetails = await service.getSalaryDetails(id: id);

      loading = false;
      onSuccess('');
    } catch (e) {
      loading = false;
      onError("something went wrong!");
    }
  }
}
