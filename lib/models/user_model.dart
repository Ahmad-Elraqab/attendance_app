class UserModel {
  String? userType,
      firstName,
      lastName,
      userImage,
      phone,
      mobileNo,
      role,
      email,
      mobileMacAddress,
      logo,
      sid,
      message,
      homePage,
      primaryColor,
      secondaryColor,
      useMobileApp,
      fullName;
  int? mobileActivated;

  UserModel({
    this.phone,
    this.userType,
    this.firstName,
    this.lastName,
    this.userImage,
    this.mobileNo,
    this.role,
    this.email,
    this.mobileMacAddress,
    this.logo,
    this.sid,
    this.message,
    this.homePage,
    this.primaryColor,
    this.secondaryColor,
    this.useMobileApp,
    this.fullName,
    this.mobileActivated,
  });

  UserModel copyWith({
    String? strUserId,
    String? userName,
  }) =>
      UserModel();

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        phone: json['user_data']['phone'],
        userType: json['user_data']['user_type'],
        firstName: json['user_data']['first_name'],
        lastName: json['user_data']['last_name'],
        userImage: json['user_data']['user_image'],
        mobileNo: json['user_data']['mobile_no'],
        role: json['user_data']['role'],
        email: json['user_data']['email'],
        mobileMacAddress: json['user_data']['mobile_mac_address'],
        fullName: json['user_data']['fullName'],
        mobileActivated: json['user_data']['mobile_activated'],
        //
        homePage: json['home_page'],
        sid: json['sid'],
        message: json['message'],
        //
        logo: json['company_data']['logo'],
        primaryColor: json['company_data']['primary_color'],
        secondaryColor: json['company_data']['secondary_color'],
        useMobileApp: json['company_data']['use_mobile_app'],
      );

  Map<dynamic, dynamic> toJson() {
    var json = {
      'user_data': {
        'phone': phone,
        'user_type': userType,
        'first_name': firstName,
        'last_name': lastName,
        'user_image': userImage,
        'mobile_no': mobileNo,
        'role': role,
        'email': email,
        'mobile_mac_address': mobileMacAddress,
        'fullName': fullName,
        'mobile_activated': mobileActivated,
      },
      'company_data': {
        'logo': logo,
        'primary_color': primaryColor,
        'secondary_color': secondaryColor,
        'use_mobile_app': useMobileApp,
      },
      'home_page': homePage,
      'sid': sid,
      'message': message,
    };

    return json;
  }
}
