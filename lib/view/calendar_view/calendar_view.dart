import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/constants.dart';
import 'package:attendance_app/app/env/text_style.dart';
import 'package:attendance_app/view/home_view/home_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  int? filter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14.5),
        color: AppColor.reGreyBackground,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 56),
                  Text(
                    "Attendance",
                    style: AppTextStyle.bold18.copyWith(
                      color: AppColor.reBlack1C1F26,
                    ),
                  ),
                  const SizedBox(height: 14.5),
                  const LeavesComponent(),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColor.reWhiteFFFFFF,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Leave Requests",
                              style: AppTextStyle.bold16.copyWith(
                                color: AppColor.reBlack1C1F26,
                              ),
                            ),
                            SvgPicture.asset(
                              AppIcon.filter,
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 45,
                          width: MediaQuery.sizeOf(context).width,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColor.reGreyFAFAFA,
                          ),
                          child: ListView.builder(
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemExtent: 106,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    filter = index;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: filter == index
                                        ? AppColor.reBlue105F82
                                        : AppColor.reTransparent,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  width: 106,
                                  height: 37,
                                  child: Center(
                                    child: Text(
                                      "All",
                                      style: AppTextStyle.regular14.copyWith(
                                        color: filter == index
                                            ? AppColor.reWhiteFFFFFF
                                            : AppColor.reGreyA5A5A5,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        for (var i = 0; i < 10; i++)
                          Container(
                            margin: i == 9
                                ? null
                                : const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.reBlack1D1F1F.withOpacity(.1),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Dec 30, 2023",
                                      style: AppTextStyle.bold16.copyWith(
                                        color: AppColor.reBlack1C1F26,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4,
                                        horizontal: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(27),
                                        color: AppColor.reOrangeFF9500
                                            .withOpacity(.1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Pending",
                                          style:
                                              AppTextStyle.regular12.copyWith(
                                            color: AppColor.reOrangeFF9500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Yorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                  style: AppTextStyle.regular14.copyWith(
                                    color: AppColor.reGrey666666,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 6,
                                      backgroundColor: AppColor.reOrangeFF9500,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "Sick",
                                      style: AppTextStyle.regular14.copyWith(
                                        color: AppColor.reBlack1C1F26,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: bottomNavigationHeight),
                ],
              ),
            ),
            Positioned(
              right: 0,
              bottom: 90,
              child: Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.reBlue105F82,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppIcon.add,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
