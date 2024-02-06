import 'dart:math';

import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/constants.dart';
import 'package:attendance_app/app/env/text_style.dart';
import 'package:attendance_app/app/router/router.gr.dart';
import 'package:attendance_app/app/widgets/app_global_functions.dart';
import 'package:attendance_app/view/home_view/home_view.dart';
import 'package:attendance_app/view_models/leave_viewmodel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
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
            RefreshIndicator.adaptive(
              onRefresh: () async {
                context
                    .read<LeaveViewmodel>()
                    .getLeaveTypes(onError: (val) {}, onSuccess: (val) {});
                context
                    .read<LeaveViewmodel>()
                    .getLeaves(onError: (val) {}, onSuccess: (val) {});
              },
              child: SingleChildScrollView(
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
                    const LeavesListView(),
                    const SizedBox(height: bottomNavigationHeight),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 90,
              child: InkWell(
                onTap: () {
                  context.router.root.push(const LeaveApplicationView());
                },
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
            ),
          ],
        ),
      ),
    );
  }
}

class LeavesListView extends StatefulWidget {
  const LeavesListView({super.key});

  @override
  State<LeavesListView> createState() => _LeavesListViewState();
}

class _LeavesListViewState extends State<LeavesListView> {
  int? selectedBottomSheetFilter;
  // int? selectedBottomSheetTypeFilter;
  int? filter = 0;
  String? filterName;

  @override
  void initState() {
    loadLeaveTypes();
    super.initState();
  }

  Future<void> loadLeaveTypes() async {
    context.read<LeaveViewmodel>().getLeaveTypes(
          onError: (val) {
            showSnackbar(context, val, SnackbarMessageType.warning);
          },
          onSuccess: (val) {},
        );
  }

  List listStatus = ['Pending', 'Approved', 'Rejected'];
  @override
  Widget build(BuildContext context) {
    return Consumer<LeaveViewmodel>(
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.reWhiteFFFFFF,
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (value.loading)
                const SizedBox(
                    height: 354,
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ))
              else if (value.leaveTypes == null || value.leaveTypes!.isEmpty)
                Center(
                  child: SizedBox(
                      height: 354,
                      child: Center(
                        child: Text(
                          "No Leaves are made yet",
                          style: AppTextStyle.semiBold16.copyWith(
                            color: AppColor.reGrey666666,
                          ),
                        ),
                      )),
                )
              else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Leave Requests",
                      style: AppTextStyle.bold16.copyWith(
                        color: AppColor.reBlack1C1F26,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isDismissible: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          backgroundColor: AppColor.reWhiteFFFFFF,
                          // isScrollControlled: true,
                          clipBehavior: Clip.hardEdge,
                          builder: (context) {
                            // List listType = ['Sick', 'Casual'];
                            return StatefulBuilder(
                              builder: (context, setInitState) => Container(
                                // height: 409,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: AppColor.reWhiteFFFFFF,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Leaves Filter",
                                          style: AppTextStyle.bold16.copyWith(
                                            color: AppColor.reBlack1C1F26,
                                          ),
                                        ),
                                        SvgPicture.asset(AppIcon.close)
                                      ],
                                    ),
                                    const SizedBox(height: 22),
                                    Text(
                                      "Status",
                                      style: AppTextStyle.regular16.copyWith(
                                        color: AppColor.reGrey666666,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Wrap(
                                      spacing: 8,
                                      direction: Axis.horizontal,
                                      runAlignment: WrapAlignment.start,
                                      children: [
                                        for (var i = 0; i < 3; i++)
                                          InkWell(
                                            onTap: () {
                                              setInitState(() {
                                                selectedBottomSheetFilter = i;
                                              });
                                              setState(() {
                                                selectedBottomSheetFilter = i;
                                              });
                                            },
                                            child: Container(
                                              width: 110,
                                              // constraints: BoxConstraints.expand(),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 17.5,
                                                horizontal: 16,
                                              ),
                                              decoration: BoxDecoration(
                                                color:
                                                    selectedBottomSheetFilter ==
                                                            i
                                                        ? AppColor.reBlue105F82
                                                        : AppColor
                                                            .reWhiteFFFFFF,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border:
                                                    selectedBottomSheetFilter ==
                                                            i
                                                        ? null
                                                        : Border.all(
                                                            color: AppColor
                                                                .reBlack1D1F1F
                                                                .withOpacity(
                                                                    .1),
                                                            width: 1,
                                                          ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  listStatus[i],
                                                  style: AppTextStyle.regular14
                                                      .copyWith(
                                                          color: selectedBottomSheetFilter ==
                                                                  i
                                                              ? AppColor
                                                                  .reWhiteFFFFFF
                                                              : AppColor
                                                                  .reGrey666666),
                                                ),
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      "Type",
                                      style: AppTextStyle.regular16.copyWith(
                                        color: AppColor.reGrey666666,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Wrap(
                                      spacing: 8,
                                      direction: Axis.horizontal,
                                      runAlignment: WrapAlignment.start,
                                      children: [
                                        for (var i = 0;
                                            i < value.leaveTypes!.length + 1;
                                            i++)
                                          InkWell(
                                            onTap: () {
                                              setInitState(() {
                                                filter = i;
                                              });
                                              setState(() {
                                                filter = i;
                                              });
                                            },
                                            child: Container(
                                              width: 150,
                                              // constraints: BoxConstraints.expand(),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 17.5,
                                                horizontal: 16,
                                              ),
                                              decoration: BoxDecoration(
                                                color: filter == i
                                                    ? AppColor.reBlue105F82
                                                    : AppColor.reWhiteFFFFFF,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: filter == i
                                                    ? null
                                                    : Border.all(
                                                        color: AppColor
                                                            .reBlack1D1F1F
                                                            .withOpacity(.1),
                                                        width: 1,
                                                      ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  i == 0
                                                      ? 'الكل'
                                                      : value.leaveTypes![i - 1]
                                                          .leaveTypeName
                                                          .toString(),
                                                  style: AppTextStyle.regular14
                                                      .copyWith(
                                                          color: filter == i
                                                              ? AppColor
                                                                  .reWhiteFFFFFF
                                                              : AppColor
                                                                  .reGrey666666),
                                                ),
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                    const SizedBox(height: 28),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setInitState(() {
                                              filter = 0;
                                              selectedBottomSheetFilter = null;
                                            });
                                            setState(() {
                                              filter = 0;
                                              selectedBottomSheetFilter = null;
                                            });

                                            context.router.pop();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: AppColor.reBlue105F82),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Reset",
                                                style: AppTextStyle.medium16
                                                    .copyWith(
                                                  color: AppColor.reBlue105F82,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              context.router.pop();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: AppColor.reBlue105F82,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color:
                                                        AppColor.reBlue105F82),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Apply",
                                                  style: AppTextStyle.medium16
                                                      .copyWith(
                                                    color:
                                                        AppColor.reWhiteFFFFFF,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: SvgPicture.asset(
                        AppIcon.filter,
                      ),
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
                    itemCount: value.leaveTypes!.length + 1,
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
                              index == 0
                                  ? 'الكل'
                                  : value.leaveTypes![index - 1].name
                                      .toString(),
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
                Builder(
                  builder: (context) {
                    var filteredList;
                    if (filter != null && filter != 0) {
                      filteredList = value.userLeaves!.where((e) {
                        if (selectedBottomSheetFilter != null) {
                          if (e.leaveType ==
                                  value
                                      .leaveTypes![filter! - 1].leaveTypeName &&
                              e.status ==
                                  listStatus[selectedBottomSheetFilter!]) {
                            return true;
                          } else {
                            return false;
                          }
                        } else if (e.leaveType ==
                            value.leaveTypes![filter! - 1].leaveTypeName) {
                          return true;
                        } else {
                          return false;
                        }
                      }).toList();
                    } else {
                      filteredList = value.userLeaves!;
                    }

                    if (filteredList == null || filteredList.isEmpty) {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Text(
                            "No results for ${value.leaveTypes![filter! - 1].leaveTypeName}",
                            style: AppTextStyle.semiBold16.copyWith(
                              color: AppColor.reGrey666666,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          for (var i = 0; i < filteredList.length; i++)
                            Container(
                              margin: i == filteredList.length - 1
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
                                      Builder(
                                        builder: (context) {
                                          final date = DateTime.parse(
                                              filteredList![i]
                                                  .postingDate
                                                  .toString());
                                          return Text(
                                            // "Dec 30, 2023",
                                            "${getMonth(date.month)} ${date.day}, ${date.year}",
                                            style: AppTextStyle.bold16.copyWith(
                                              color: AppColor.reBlack1C1F26,
                                            ),
                                          );
                                        },
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(27),
                                          color: AppColor.reOrangeFF9500
                                              .withOpacity(.1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            // "Pending",
                                            filteredList[i].status.toString(),
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
                                    // "Yorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                    filteredList[i].employeeName.toString(),
                                    style: AppTextStyle.regular14.copyWith(
                                      color: AppColor.reGrey666666,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 6,
                                        backgroundColor:
                                            AppColor.reOrangeFF9500,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        // "Sick",
                                        filteredList[i].leaveType.toString(),
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
                      );
                    }
                  },
                )
              ],
            ],
          ),
        );
      },
    );
  }
}
