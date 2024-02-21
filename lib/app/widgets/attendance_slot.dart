import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AttendanceSlot extends StatelessWidget {
  const AttendanceSlot({
    super.key,
    required this.i,
  });

  final List<String> i;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(i[1]),
        const SizedBox(height: 4),
        Text(
          "09:05 AM",
          style: AppTextStyle.regular14.copyWith(
            color: AppColor.reBlue1C1F26,
          ),
        ),
        Text(
          i[0],
          style: AppTextStyle.regular14.copyWith(
            color: AppColor.reGreyA5A5A5,
          ),
        ),
      ],
    );
  }
}
