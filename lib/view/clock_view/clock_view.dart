import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/constants.dart';
import 'package:attendance_app/app/env/text_style.dart';
import 'package:attendance_app/app/widgets/app_global_functions.dart';
import 'package:attendance_app/app/widgets/attendance_grid_view.dart';
import 'package:attendance_app/app/widgets/attendance_slot.dart';
import 'package:attendance_app/view_models/attendance_viewmodel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ClockView extends StatefulWidget {
  const ClockView({super.key});

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    context.read<AttendanceViewmodel>().getAttendance(
          onError: (val) {},
          onSuccess: (val) {},
        );
    super.initState();
  }

  DateTime today = DateTime.now();

  List<bool> _isOpen = List.generate(10, (index) => false);
  List<ExpandableController> controllers = List.generate(
      10, (index) => ExpandableController(initialExpanded: false));
  // final desc = ['Early Leaves', 'Absents', 'Late In', 'Leaves'];
  final colors = [
    AppColor.rePurple6A6AF6,
    AppColor.reBlue105F82,
    AppColor.reRedFF3B30,
    AppColor.reYellowFF9500
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14.5),
      color: AppColor.reGreyBackground,
      child: Consumer<AttendanceViewmodel>(
        builder: (context, value, child) => value.loading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : value.attendance == null
                ? Center(
                    child: Text(
                      "Empty attendance list",
                      style: AppTextStyle.bold18.copyWith(
                        color: AppColor.reBlack1C1F26,
                      ),
                    ),
                  )
                : SingleChildScrollView(
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
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.reWhiteFFFFFF,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${getMonth(today.month - 1)} ${today.year}",
                                    style: AppTextStyle.bold16.copyWith(
                                      color: AppColor.reBlack1C1F26,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    AppIcon.calendarFill,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              AttendanceGridView(attendance: value.attendance!),
                              const SizedBox(height: 8),
                              Text(
                                "Days",
                                style: AppTextStyle.regular12.copyWith(
                                  color: AppColor.reGrey666666,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // for (var i = 0; i < controllers.length; i++)
                              // _buildWeeks(i),
                              for (var i = 0; i < value.attendance!.length; i++)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: i % 2 == 0
                                        ? AppColor.reWhiteFFFFFF
                                        : AppColor.reGreyFAFAFA,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  height: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            if (value
                                                    .attendance![i].earlyExit ==
                                                1) ...[
                                              CircleAvatar(
                                                radius: 5,
                                                backgroundColor:
                                                    AppColor.rePurple6A6AF6,
                                              ),
                                              const SizedBox(width: 5)
                                            ],
                                            if (value
                                                    .attendance![i].lateEntry ==
                                                1) ...[
                                              CircleAvatar(
                                                radius: 5,
                                                backgroundColor:
                                                    AppColor.reRedFF3B30,
                                              ),
                                              const SizedBox(width: 5)
                                            ],
                                            if (value.attendance![i].status ==
                                                'Present') ...[
                                              CircleAvatar(
                                                radius: 5,
                                                backgroundColor:
                                                    AppColor.reYellowFF9500,
                                              ),
                                              const SizedBox(width: 5)
                                            ],
                                            if (value.attendance![i].status ==
                                                'Absent') ...[
                                              CircleAvatar(
                                                radius: 5,
                                                backgroundColor:
                                                    AppColor.reBlue105F82,
                                              ),
                                              const SizedBox(width: 5)
                                            ]
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 56,
                                              decoration: BoxDecoration(
                                                color: AppColor.reGreyEEEEEE,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              margin: const EdgeInsets.only(
                                                  right: 8),
                                              child: Center(
                                                child: Text.rich(
                                                  textAlign: TextAlign.center,
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            '${value.attendance![i].attendanceDate!.day.toString().padLeft(2, '0')}\n',
                                                        style: AppTextStyle
                                                            .regular14
                                                            .copyWith(
                                                          color: AppColor
                                                              .reBlue1C1F26,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: getWeekDay(value
                                                                .attendance![i]
                                                                .attendanceDate!
                                                                .weekday)
                                                            .substring(0, 3)
                                                            .toUpperCase(),
                                                        style: AppTextStyle
                                                            .regular12
                                                            .copyWith(
                                                          color: AppColor
                                                              .reBlue1C1F26,
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
                                                      child:
                                                          AttendanceSlot(i: i),
                                                    ),
                                                    if (i[0] != 'Total Hrs')
                                                      Container(
                                                        height: 20,
                                                        width: 1,
                                                        color: AppColor
                                                            .reGreyA5A5A5,
                                                      )
                                                  ],
                                                ),
                                              )
                                          ],
                                        ),
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
      ),
    );
  }

  Container _buildWeeks(int i) {
    return Container(
      margin: EdgeInsets.only(bottom: i == controllers.length - 1 ? 0 : 8),
      child: ExpandablePanel(
        theme: const ExpandableThemeData(
            tapHeaderToExpand: true,
            tapBodyToExpand: true,
            tapBodyToCollapse: true,
            useInkWell: true,
            animationDuration: Duration(milliseconds: 500)),
        controller: controllers[i],
        collapsed: InkWell(
          onTap: () {
            setState(() {
              controllers[i].expanded = !controllers[i].expanded;
            });
          },
          child: _buildHeader(),
        ),
        expanded: InkWell(
          onTap: () {
            setState(() {
              controllers[i].expanded = !controllers[i].expanded;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.reWhiteFFFFFF,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildHeader(isExpanded: true),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColor.reWhiteFFFFFF,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12)),
                    border: Border.all(
                      color: AppColor.reBlack1D1F1F.withOpacity(.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      for (var i = 2; i < 7; i++)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 4),
                          decoration: BoxDecoration(
                            color: i % 2 == 0
                                ? AppColor.reWhiteFFFFFF
                                : AppColor.reGreyFAFAFA,
                            borderRadius: BorderRadius.circular(12),
                          ),
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
                                          style:
                                              AppTextStyle.regular14.copyWith(
                                            color: AppColor.reBlue1C1F26,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'SUN',
                                          style:
                                              AppTextStyle.regular12.copyWith(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildHeader({bool isExpanded = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9.5),
      decoration: BoxDecoration(
        color: AppColor.reGreyFAFAFA,
        borderRadius: isExpanded
            ? const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))
            : BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.reBlack1D1F1F.withOpacity(.1),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Week 2",
                style: AppTextStyle.bold16.copyWith(
                  color: AppColor.reBlue1C1F26,
                ),
              ),
              Text(
                "14 - 20 Jan",
                style: AppTextStyle.regular14.copyWith(
                  color: AppColor.reGrey666666,
                ),
              )
            ],
          ),
          SvgPicture.asset(AppIcon.arrowDown),
        ],
      ),
    );
  }
}
