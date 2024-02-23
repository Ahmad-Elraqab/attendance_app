class AttendanceModel {
  String? name, status, department, shift;
  DateTime? attendanceDate;
  int? lateEntry, earlyExit;

  AttendanceModel({
    this.name,
    this.attendanceDate,
    this.department,
    this.earlyExit,
    this.lateEntry,
    this.shift,
    this.status,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
        attendanceDate: DateTime.parse(json['attendance_date']),
        department: json['department'],
        earlyExit: json['early_exit'],
        lateEntry: json['late_entry'],
        name: json['name'],
        shift: json['shift'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "status": status,
        "attendance_date": attendanceDate.toString(),
        "department": department,
        "late_entry": lateEntry,
        "early_exit": earlyExit,
        "shift": shift,
      };
}
