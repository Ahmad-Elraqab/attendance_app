import 'package:attendance_app/app/data_sources/local_storage/auth_token_storage.dart';
import 'package:attendance_app/app/data_sources/remote/rest_service.dart';
import 'package:attendance_app/models/attendance_model.dart';
import 'package:attendance_app/models/attendance_status_model.dart';
import 'package:dio/dio.dart';

class AttendanceService {
  AttendanceService({required this.restService, required this.localStorage});

  RestService restService;
  AuthTokenStorage localStorage;

  Future<String> checkIn(
      double lat, double long, String deviceId, String type) async {
    try {
      final token = await localStorage.getToken();

      print("deviceId");
      print(deviceId);
      var headers = {'Cookie': 'sid=$token;'};

      final response = await restService.dio.get(
        "/api/method/flow_branding.api.mobile_api.add_check_in_by_user?log_type=$type&latitude=30.0820159&longitude=31.6397072&mobile_identifier=12345678987656789",
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      );

      return response.data['message']['msg'];
    } catch (e) {
      rethrow;
    }
  }

  Future<AttendanceStatusModel> getLastCheck() async {
    try {
      final token = await localStorage.getToken();

      var headers = {'Cookie': 'sid=$token;'};

      final response = await restService.dio.get(
        '/api/method/flow_branding.api.mobile_api.get_last_check_in_type_by_user',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if ((response.data['message'] as Map).isEmpty) {
        throw 'firstTime';
      } else {
        final attendanceStatus =
            AttendanceStatusModel.fromJson(response.data['message']);
        return attendanceStatus;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AttendanceModel>?> getAttendance() async {
    try {
      final token = await localStorage.getToken();

      var headers = {'Cookie': 'sid=$token;'};

      final response = await restService.dio.get(
        'https://dev.qatarat-alnada.com/api/method/flow_branding.api.mobile_api.get_attendance_list_by_user',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      final attendance = (response.data['message'] as List)
          .map((e) => AttendanceModel.fromJson(e))
          .toList();
      return attendance;
    } catch (e) {
      rethrow;
    }
  }
}
