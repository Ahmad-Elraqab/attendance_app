import 'package:attendance_app/app/app_extension/app_extensions.dart';
import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/constants.dart';
import 'package:attendance_app/app/env/text_style.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class LeaveApplicationView extends StatefulWidget {
  const LeaveApplicationView({super.key});

  @override
  State<LeaveApplicationView> createState() => _LeaveApplicationViewState();
}

class _LeaveApplicationViewState extends State<LeaveApplicationView> {
  DateTime? selectedDateTime;
  int selectedType = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.reGreyBackground,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 54),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.5),
                child: Row(
                  children: [
                    SvgPicture.asset(AppIcon.arrowLeft),
                    const SizedBox(width: 16),
                    Text(
                      "Apply a Leave",
                      style: AppTextStyle.bold18
                          .copyWith(color: AppColor.reBlack1C1F26),
                    ),
                  ],
                ),
              ),
              Text(
                "Type of leave *",
                style: AppTextStyle.regular16
                    .copyWith(color: AppColor.reGrey666666),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedType = 0;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 17.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color:
                              selectedType == 0 ? AppColor.reBlue105F82 : null,
                          border: selectedType == 0
                              ? null
                              : Border.all(
                                  color: AppColor.reBlack1D1F1F.withOpacity(.1),
                                  width: 1,
                                ),
                        ),
                        child: Center(
                          child: Text(
                            "Casual",
                            style: AppTextStyle.regular14.copyWith(
                              color: selectedType == 0
                                  ? AppColor.reWhiteFFFFFF
                                  : AppColor.reGrey666666,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedType = 1;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 17.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color:
                              selectedType == 1 ? AppColor.reBlue105F82 : null,
                          border: selectedType == 1
                              ? null
                              : Border.all(
                                  color: AppColor.reBlack1D1F1F.withOpacity(.1),
                                  width: 1,
                                ),
                        ),
                        child: Center(
                          child: Text(
                            "Sick",
                            style: AppTextStyle.regular14.copyWith(
                              color: selectedType == 1
                                  ? AppColor.reWhiteFFFFFF
                                  : AppColor.reGrey666666,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "Date *",
                style: AppTextStyle.regular16
                    .copyWith(color: AppColor.reGrey666666),
              ),
              const SizedBox(height: 8),
              CalendarCarousel<Event>(
                onDayPressed: (DateTime date, List<Event> events) {
                  setState(() {
                    selectedDateTime = date;
                  });
                },
                thisMonthDayBorderColor: Colors.grey,
                headerTextStyle: AppTextStyle.semiBold20
                    .copyWith(color: AppColor.reBlack393939),
                iconColor: AppColor.reBlack393939,
                todayButtonColor: AppColor.reTransparent,
                todayBorderColor: AppColor.reTransparent,
                customDayBuilder: (
                  bool isSelectable,
                  int index,
                  bool isSelectedDay,
                  bool isToday,
                  bool isPrevMonthDay,
                  TextStyle textStyle,
                  bool isNextMonthDay,
                  bool isThisMonthDay,
                  DateTime day,
                ) {
                  return Center(
                    child: Container(
                      height: 49,
                      width: 49,
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        // color: AppColor.reGreyF9F9F9,
                        borderRadius: BorderRadius.circular(100),
                        color: selectedDateTime == day
                            ? AppColor.reBlue105F82
                            : AppColor.reTransparent,
                        border: Border.all(
                          color: AppColor.reTransparent,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          day.day.toString(),
                          style: AppTextStyle.regular16.copyWith(
                            color: (isNextMonthDay ||
                                    isPrevMonthDay ||
                                    !DateTime.now().compareTo(day).isNegative)
                                ? AppColor.reGreyA5A5A5
                                : day == selectedDateTime
                                    ? AppColor.reWhiteFFFFFF
                                    : AppColor.reBlack1C1F26,
                            // fontWeight: isThisMonthDay ? FontWeight.bold : null,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                weekFormat: false,
                height: 400.0,
                childAspectRatio: 1,
                customGridViewPhysics: const NeverScrollableScrollPhysics(),
                daysTextStyle: AppTextStyle.medium16
                    .copyWith(color: AppColor.reBlack393939),
                headerMargin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                customWeekDayBuilder: (weekday, weekdayName) => SizedBox(
                  width: 32,
                  height: 30,
                  child: Text(
                    weekdayName,
                    style: AppTextStyle.regular14
                        .copyWith(color: AppColor.reBlack1C1F26),
                  ),
                ),
              ),
              Text(
                "Note",
                style: AppTextStyle.regular16
                    .copyWith(color: AppColor.reGrey666666),
              ),
              const SizedBox(height: 8),
              TextField().formTextField(
                maxLines: 3,
                label: 'write your note here...',
              ),
              const SizedBox(height: 16),
              Container().labelButton(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isDismissible: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: AppColor.reWhiteFFFFFF,
                    isScrollControlled: true,
                    builder: (context) {
                      return Container(
                        height: 450,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Request Pending",
                              style: AppTextStyle.bold16.copyWith(
                                color: AppColor.reBlack1C1F26,
                              ),
                            ),
                            const SizedBox(height: 47),
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                AppIcon.timer,
                                height: 150,
                              ),
                            ),
                            const SizedBox(height: 47),
                            Text(
                              "Your request has been received and we will let you know as soon as possible.",
                              style: AppTextStyle.regular16.copyWith(
                                color: AppColor.reGrey666666,
                              ),
                            ),
                            const SizedBox(height: 32),
                            Container().labelButton(
                              onTap: () {
                                context.router.popUntilRoot();
                              },
                              label: 'Back to home',
                              appTextStyle: AppTextStyle.medium16
                                  .copyWith(color: AppColor.reWhiteFFFFFF),
                              color: AppColor.reBlue105F82,
                              verticalPadding: 16,
                              radius: 12,
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                label: 'Apply',
                appTextStyle: AppTextStyle.medium16
                    .copyWith(color: AppColor.reWhiteFFFFFF),
                color: AppColor.reBlue105F82,
                verticalPadding: 16,
                radius: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
