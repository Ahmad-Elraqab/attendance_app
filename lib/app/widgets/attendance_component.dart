import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/constants.dart';
import 'package:attendance_app/app/env/text_style.dart';
import 'package:attendance_app/app/widgets/attendance_grid_view.dart';
import 'package:attendance_app/app/widgets/attendance_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AttendanceComponent extends StatelessWidget {
  const AttendanceComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.reWhiteFFFFFF,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Attendance",
                style: AppTextStyle.bold18.copyWith(
                  color: AppColor.reBlue1C1F26,
                ),
              ),
              SvgPicture.asset(
                AppIcon.arrowRight,
                height: 18,
                width: 18,
                color: AppColor.reBlue1C1F26,
              )
            ],
          ),
          const SizedBox(height: 8),
          AttendanceGridView(),
          const SizedBox(height: 8),
          Text(
            "Last 5 days, attended",
            style: AppTextStyle.regular12.copyWith(
              color: AppColor.reGrey666666,
            ),
          ),
          const SizedBox(height: 8),
          for (var i = 2; i < 7; i++)
            Container(
              padding: const EdgeInsets.all(4),
              height: 77,
              child: Row(
                children: [
                  Container(
                    width: 56,
                    decoration: BoxDecoration(
                      color: AppColor.reGreyEEEEEE,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.only(right: 8),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: ' 0$i\n',
                              style: AppTextStyle.regular14.copyWith(
                                color: AppColor.reBlue1C1F26,
                              ),
                            ),
                            TextSpan(
                              text: 'SUN',
                              style: AppTextStyle.regular12.copyWith(
                                color: AppColor.reBlue1C1F26,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  for (var i in [
                    ['Check in', AppIcon.checkGreen],
                    ['Check out', AppIcon.checkRed],
                    ['Total Hrs', AppIcon.check],
                  ])
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: AttendanceSlot(i: i),
                          ),
                          if (i[0] != 'Total Hrs')
                            Container(
                              height: 20,
                              width: 1,
                              color: AppColor.reGreyA5A5A5,
                            )
                        ],
                      ),
                    )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
