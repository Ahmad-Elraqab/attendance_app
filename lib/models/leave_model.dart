// "name": "HR-LAP-2024-00003",
// "from_date": "2024-08-23",
// "to_date": "2024-08-24",
// "status": "Open",
// "employee_name": "NASIR KABARI",
// "leave_type": "اجازة من دون راتب",
// "leave_balance": 0.0,
// "posting_date": "2024-02-01",
// "workflow_state": "Draft",
// "action": "Send Leave:Pending Replacement,Super Approve:Approved"

class LeaveModel {
  final String? name,
      fromDate,
      toDate,
      status,
      employeeName,
      leaveType,
      postingDate,
      workflowState,
      action;
  double? leaveBalance;

  LeaveModel({
    this.action,
    this.employeeName,
    this.fromDate,
    this.leaveBalance,
    this.leaveType,
    this.name,
    this.postingDate,
    this.status,
    this.toDate,
    this.workflowState,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) => LeaveModel(
        name: json['name'],
        fromDate: json['from_date'],
        toDate: json['to_date'],
        status: json['status'],
        employeeName: json['employee_name'],
        leaveType: json['leave_type'],
        leaveBalance: json['leave_balance'],
        postingDate: json['posting_date'],
        workflowState: json['workflow_state'],
        action: json['action'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'from_date': fromDate,
        'to_date': toDate,
        'status': status,
        'employee_name': employeeName,
        'leave_type': leaveType,
        'leave_balance': leaveBalance,
        'posting_date': postingDate,
        'workflow_state': workflowState,
        'action': action,
      };
}
