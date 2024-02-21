import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/constants.dart';
import 'package:attendance_app/app/env/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum SnackbarMessageType { success, warning, info, message }

void showSnackbar(context, message, SnackbarMessageType type,
    {Function? onTap}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: type == SnackbarMessageType.info
          ? AppColor.reBlueCFD8F9
          : type == SnackbarMessageType.message
              ? AppColor.reBlueCFD8F9
              : type == SnackbarMessageType.success
                  ? AppColor.reGreenBEE988
                  : AppColor.reRedF3B7B7,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: type == SnackbarMessageType.info
              ? AppColor.reBlueCFD8F9
              : type == SnackbarMessageType.message
                  ? AppColor.reBlueCFD8F9
                  : type == SnackbarMessageType.success
                      ? AppColor.reGreenBEE988
                      : AppColor.reRedF3B7B7,
        ),
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
          onTap: () => onTap!(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                type == SnackbarMessageType.info
                    ? AppIcon.info
                    : type == SnackbarMessageType.message
                        ? AppIcon.handWave
                        : type == SnackbarMessageType.success
                            ? AppIcon.check
                            : AppIcon.info,
                color: type == SnackbarMessageType.info
                    ? AppColor.reBlue142F8C
                    : type == SnackbarMessageType.message
                        ? AppColor.reBlue142F8C
                        : type == SnackbarMessageType.success
                            ? AppColor.reGreen3E650D
                            : AppColor.reRed700707,
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Text(
                  // 'Hi there.  Sign up or login now to enjoy the complete Spanar experience!',
                  // 'Please accept our Term and Conditions',
                  message.toString(),
                  maxLines: 3,
                  style: AppTextStyle.semiBold14.copyWith(
                    color: type == SnackbarMessageType.info
                        ? AppColor.reBlue142F8C
                        : type == SnackbarMessageType.message
                            ? AppColor.reBlue142F8C
                            : type == SnackbarMessageType.success
                                ? AppColor.reGreen3E650D
                                : AppColor.reRed700707,
                  ),
                ),
              ),
              const SizedBox(width: 11),
              GestureDetector(
                onTap: () =>
                    ScaffoldMessenger.of(context).removeCurrentSnackBar(),
                child: SvgPicture.asset(
                  AppIcon.close,
                  color: type == SnackbarMessageType.info
                      ? AppColor.reBlue142F8C
                      : type == SnackbarMessageType.message
                          ? AppColor.reBlue142F8C
                          : type == SnackbarMessageType.success
                              ? AppColor.reGreen3E650D
                              : AppColor.reRed700707,
                ),
              ),
            ],
          ),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 200,
        right: 20,
        left: 20,
      ),
    ),
  );
}

String getMonth(index) => [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ][index];
String getMonthShort(index) => [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ][index];
String getWeekDay(index) => [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ][index];
