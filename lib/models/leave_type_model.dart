class LeaveTypeModel {
  final String? name, leaveTypeName;

  LeaveTypeModel({this.leaveTypeName, this.name});

  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) => LeaveTypeModel(
        leaveTypeName: json['leave_type_name'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'leave-type-name': leaveTypeName,
        'name': name,
      };
}
