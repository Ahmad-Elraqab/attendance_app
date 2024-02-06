import 'package:attendance_app/app/data_sources/local_storage/auth_token_storage.dart';
import 'package:attendance_app/app/data_sources/remote/rest_service.dart';

class AttendanceService {
  AttendanceService({required this.restService, required this.localStorage});

  RestService restService;
  AuthTokenStorage localStorage;

  Future<void> checkIn(double lat, double long) async {
    try {
      final token = await localStorage.getToken();

      final response = await restService.dio.get(
          "/api/method/flow_branding.api.mobile_apiadd_check_in_by_user?log_type=IN&latitude=$lat&longitude=$long&mobile_identifier=12345678987656789&sid=$token");
    } catch (e) {
      rethrow;
    }
  }
}
