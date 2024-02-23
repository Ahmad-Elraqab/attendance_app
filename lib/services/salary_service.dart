import 'package:attendance_app/app/data_sources/local_storage/auth_token_storage.dart';
import 'package:attendance_app/app/data_sources/remote/rest_service.dart';
import 'package:attendance_app/models/attendance_model.dart';
import 'package:attendance_app/models/salary_details_model.dart';
import 'package:attendance_app/models/salary_model.dart';
import 'package:dio/dio.dart';

class SalaryService {
  SalaryService({required this.restService, required this.localStorage});

  RestService restService;
  AuthTokenStorage localStorage;

  Future<List<SalaryModel>?> getSalaries() async {
    try {
      final token = await localStorage.getToken();

      var headers = {'Cookie': 'sid=$token;'};

      final response = await restService.dio.post(
        'https://dev.qatarat-alnada.com/api/method/flow_branding.api.mobile_api.get_salary_list_by_user',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      );

      final salaries = (response.data['message'] as List)
          .map((e) => SalaryModel.fromJson(e))
          .toList();

      return salaries;
    } catch (e) {
      rethrow;
    }
  }

  Future<SalaryDetailsModel> getSalaryDetails({required String id}) async {
    try {
      final token = await localStorage.getToken();

      var headers = {'Cookie': 'sid=$token;'};

      final response = await restService.dio.post(
        'https://dev.qatarat-alnada.com/api/method/flow_branding.api.mobile_api.get_salary_details?name=$id',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      );

      final salaryDetails =
          SalaryDetailsModel.fromJson(response.data['message']);

      return salaryDetails;
    } catch (e) {
      rethrow;
    }
  }
}
