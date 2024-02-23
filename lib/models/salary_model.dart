class SalaryModel {
  String? name, postingDate, startDate, endDate, totalInWords;
  double? grossPay, totalDeduction;

  SalaryModel({
    this.name,
    this.postingDate,
    this.startDate,
    this.endDate,
    this.totalDeduction,
    this.grossPay,
    this.totalInWords,
  });

  factory SalaryModel.fromJson(Map<String, dynamic> json) => SalaryModel(
        totalDeduction: json['total_deduction'],
        totalInWords: json['total_in_words'],
        name: json['name'],
        endDate: json['end_date'],
        startDate: json['start_date'],
        grossPay: json['gross_pay'],
        postingDate: json['posting_date'],
      );
  Map<String, dynamic> toJson() => {
        'total_deduction': totalDeduction,
        'total_in_words': totalInWords,
        'name': name,
        'end_date': endDate,
        'start_date': startDate,
        'gross_pay': grossPay,
        'posting_date': postingDate,
      };
}
