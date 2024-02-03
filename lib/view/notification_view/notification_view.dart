import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/constants.dart';
import 'package:attendance_app/app/env/text_style.dart';
import 'package:attendance_app/app/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.reGreyBackground,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 54),
              _buildTodayNotification("Leaves Request", 2),
              const SizedBox(height: 16),
              _buildTodayNotification("Others", 5),
              const SizedBox(height: bottomNavigationHeight + 16),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildTodayNotification(String title, int count) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.reWhiteFFFFFF,
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyle.bold16.copyWith(
                  color: AppColor.reBlack1C1F26,
                ),
              ),
              InkWell(
                onTap: () {
                  context.router.push(const NotificationDetailsView());
                },
                child: Text(
                  "See all",
                  style: AppTextStyle.regular12.copyWith(
                    color: AppColor.reBlue105F82,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title == "Others" ? "Dec 10, 2023" : "Today",
            style:
                AppTextStyle.regular12.copyWith(color: AppColor.reGrey666666),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < count; i++) ...[
            NotificationItem(
                icon: AppIcon.redCheck,
                bg: AppColor.reGreyBackground,
                iconColor: AppColor.reRedFF3B30,
                textStyle: AppTextStyle.bold16
                    .copyWith(color: AppColor.reBlack1C1F26)),
            if (i != count - 1) const SizedBox(height: 8),
          ]
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.icon,
    required this.bg,
    required this.iconColor,
    required this.textStyle,
  });

  final String icon;
  final Color bg;
  final Color iconColor;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: iconColor.withOpacity(.1),
            child: Center(
              child: SvgPicture.asset(icon),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your request rejected",
                  style: textStyle,
                ),
                const SizedBox(height: 4),
                Text(
                  "Your Request for a Sick leave has been Approved.",
                  maxLines: 3,
                  style: AppTextStyle.regular12
                      .copyWith(color: AppColor.reGrey666666),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "05:00 AM",
                    style: AppTextStyle.regular12
                        .copyWith(color: AppColor.reGreyA5A5A5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
