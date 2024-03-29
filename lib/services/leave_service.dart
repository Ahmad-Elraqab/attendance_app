import 'package:attendance_app/app/data_sources/local_storage/auth_token_storage.dart';
import 'package:attendance_app/app/data_sources/remote/rest_service.dart';
import 'package:attendance_app/models/leave_model.dart';
import 'package:attendance_app/models/leave_type_model.dart';

class LeaveService {
  LeaveService({required this.restService, required this.localStorage});

  RestService restService;
  AuthTokenStorage localStorage;

  Future<(List<LeaveModel>, List<LeaveModel>, List<LeaveModel>)>
      getLeaves() async {
    try {
      final token = await localStorage.getToken();

      final response = await restService.dio.get(
          '/api/method/flow_branding.api.mobile_api.get_leave_list_by_user?sid=$token');

      final userLeaves = (response.data['message']['user_leave_list'] as List)
          .map((e) => LeaveModel.fromJson(e))
          .toList();
      final hrLeaves = (response.data['message']['hr_leave_list'] as List)
          .map((e) => LeaveModel.fromJson(e))
          .toList();
      final approverLeaves =
          (response.data['message']['approver_leave_list'] as List)
              .map((e) => LeaveModel.fromJson(e))
              .toList();

      return (userLeaves, approverLeaves, hrLeaves);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<LeaveTypeModel>> getLeaveTypes() async {
    try {
      final token = await localStorage.getToken();

      final response = await restService.dio.get(
          '/api/method/flow_branding.api.mobile_api.get_leave_type_list?sid=$token');

      final leaveTypes = (response.data['message'] as List)
          .map((e) => LeaveTypeModel.fromJson(e))
          .toList();

      // print(response.data['message']);

      return leaveTypes;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> createLeave(
      {required String startDate,
      required String endDate,
      required String type}) async {
    try {
      final token = await localStorage.getToken();

      final response = await restService.dio.post(
          '/api/method/flow_branding.api.mobile_api.create_leave_application?sid=$token&leave_type=$type&from_date=$startDate&to_date=$endDate');
      if (response.statusCode == 200 || response.statusCode == 201) {
        // print(response.data['message']);

        return response.data['message']['msg'];
      } else {
        throw response.data['message']['msg'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
