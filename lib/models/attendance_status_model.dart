// ignore: constant_identifier_names
enum AttendanceLogType { IN, OUT }

class AttendanceStatusModel {
  DateTime? time;
  AttendanceLogType? logType;

  AttendanceStatusModel({this.logType, this.time});

  factory AttendanceStatusModel.fromJson(Map<String, dynamic> json) =>
      AttendanceStatusModel(
        time: DateTime.parse(json['time']),
        logType: AttendanceLogType.values
            .where((e) =>
                e.name.toLowerCase() ==
                json['log_type'].toString().toLowerCase())
            .first,
      );
}
