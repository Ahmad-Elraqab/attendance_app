import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/constants.dart';
import 'package:attendance_app/app/env/text_style.dart';
import 'package:attendance_app/view/notification_view/notification_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class NotificationDetailsView extends StatefulWidget {
  const NotificationDetailsView({super.key});

  @override
  State<NotificationDetailsView> createState() =>
      _NotificationDetailsViewState();
}

class _NotificationDetailsViewState extends State<NotificationDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.reGreyBackground,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 54),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.5),
              child: Row(
                children: [
                  SvgPicture.asset(AppIcon.arrowLeft),
                  const SizedBox(width: 16),
                  Text(
                    "Other",
                    style: AppTextStyle.bold18
                        .copyWith(color: AppColor.reBlack1C1F26),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColor.reWhiteFFFFFF,
                ),
                padding: const EdgeInsets.all(8),
                child: Expanded(
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    padding: EdgeInsets.zero,
                    children: [
                      Text(
                        "Dec 10, 2023",
                        style: AppTextStyle.regular12
                            .copyWith(color: AppColor.reGrey666666),
                      ),
                      const SizedBox(height: 12),
                      for (var i = 0; i < 9; i++) ...[
                        NotificationItem(
                          icon: i % 2 == 0
                              ? AppIcon.notificationIcon
                              : AppIcon.message,
                          bg: AppColor.reWhiteFFFFFF,
                          iconColor: i % 2 == 0
                              ? AppColor.reYellowFF9500
                              : AppColor.reBlue105F82,
                          textStyle: AppTextStyle.regular16.copyWith(
                            color: AppColor.reBlack1C1F26,
                          ),
                        ),
                        if (i != 9 - 1) const SizedBox(height: 8),
                      ]
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
