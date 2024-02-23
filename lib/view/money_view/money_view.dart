import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/constants.dart';
import 'package:attendance_app/app/env/text_style.dart';
import 'package:attendance_app/app/widgets/app_global_functions.dart';
import 'package:attendance_app/view_models/salary_viewmodel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

@RoutePage()
class MoneyView extends StatefulWidget {
  const MoneyView({super.key});

  @override
  State<MoneyView> createState() => _MoneyViewState();
}

class _MoneyViewState extends State<MoneyView> {
  int active = 0;

  Map earnings = {
    'Basic': '10,000',
    'Incentive Pay': '1,000',
    'House Rent Allowance': '400',
    'Meal Allowance': '200',
    'Overtime': '600',
    'Total': '12,200',
  };
  Map deductions = {
    'Provident Fund': '1,200',
    'Professional Tax': '500',
    'Loan': '400',
    'Total': '2,100',
  };

  List months = [
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
    'December',
  ];

  int? selectedMonth;

  @override
  void initState() {
    final vm = context.read<SalaryViewmodel>();
    vm.getSalaries(onError: (value) {
      showSnackbar(context, value, SnackbarMessageType.warning);
    }, onSuccess: (value) {
      showSnackbar(context, value, SnackbarMessageType.message);
    }).then((value) {
      if (vm.salaries == null || vm.salaries!.isEmpty) {
        showSnackbar(context, "Empty list", SnackbarMessageType.warning);
      } else {
        vm.getSalaryDetails(
          id: vm.salaries!.first.name.toString(),
          onError: (val) {},
          onSuccess: (val) {
            setState(() {
              earnings = {
                'Basic': vm.salaryDetails!.baseNetPay.toString(),
                'Incentive Pay': vm.salaryDetails!.grossPay.toString(),
                'House Rent Allowance':
                    vm.salaryDetails!.baseGrossPay.toString(),
                'Meal Allowance': vm.salaryDetails!.leaveWithoutPay.toString(),
                'Overtime': vm.salaryDetails!.grossPay.toString(),
                'Total': vm.salaryDetails!.netPay.toString(),
              };
            });
          },
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.reGreyBackground,
      body: Consumer<SalaryViewmodel>(
        builder: (context, value, child) => value.loading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : value.salaries == null || value.salaryDetails == null
                ? Center(
                    child: Text(
                      "Something Went Wrong",
                      style: AppTextStyle.bold18.copyWith(
                        color: AppColor.reBlack1C1F26,
                      ),
                    ),
                  )
                : value.salaries!.isEmpty
                    ? Center(
                        child: Text(
                          "No Salaries available yet",
                          style: AppTextStyle.bold18.copyWith(
                            color: AppColor.reBlack1C1F26,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 54),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14.5),
                                child: Text(
                                  "Salary",
                                  style: AppTextStyle.bold18.copyWith(
                                    color: AppColor.reBlack1C1F26,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColor.reWhiteFFFFFF,
                                    borderRadius: BorderRadius.circular(16)),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "The current net salary based on ",
                                                  style: AppTextStyle.regular14
                                                      .copyWith(
                                                    color:
                                                        AppColor.reGrey666666,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${getMonthShort(DateTime.parse(value.salaryDetails!.startDate.toString()).month - 1)} ${DateTime.parse(value.salaryDetails!.startDate!).year}',
                                                  style: AppTextStyle.regular14
                                                      .copyWith(
                                                    color:
                                                        AppColor.reBlack1C1F26,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  isDismissible: true,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  backgroundColor:
                                                      AppColor.reWhiteFFFFFF,
                                                  isScrollControlled: true,
                                                  builder: (context) {
                                                    return _buildBottomSheet(
                                                        context, value);
                                                  },
                                                );
                                              },
                                              child: SvgPicture.asset(
                                                AppIcon.calendarFill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                "SR ${value.salaryDetails!.netPay}",
                                            style: AppTextStyle.bold36.copyWith(
                                              color: AppColor.reBlack1C1F26,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "/ Net Pay",
                                            style:
                                                AppTextStyle.regular14.copyWith(
                                              color: AppColor.reGreyA5A5A5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      value.salaryDetails!.totalInWords
                                          .toString(),
                                      style: AppTextStyle.regular14.copyWith(
                                        color: AppColor.reGreyA5A5A5,
                                      ),
                                    ),
                                    const SizedBox(height: 22),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: AppColor.reWhiteFFFFFF,
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: Text(
                                        "Details",
                                        style: AppTextStyle.bold16.copyWith(
                                            color: AppColor.reBlack1C1F26),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: AppColor.reGreyBackground,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  active = 0;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: active == 1
                                                      ? AppColor
                                                          .reGreyBackground
                                                      : AppColor.reBlue105F82,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8),
                                                child: Center(
                                                  child: Text(
                                                    "Earning",
                                                    style: AppTextStyle
                                                        .regular14
                                                        .copyWith(
                                                      color: active == 1
                                                          ? AppColor
                                                              .reGreyA5A5A5
                                                          : AppColor
                                                              .reWhiteFFFFFF,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  active = 1;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: active == 1
                                                      ? AppColor.reBlue105F82
                                                      : AppColor
                                                          .reGreyBackground,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8),
                                                child: Center(
                                                  child: Text(
                                                    "Deductions",
                                                    style: AppTextStyle
                                                        .regular14
                                                        .copyWith(
                                                      color: active == 1
                                                          ? AppColor
                                                              .reWhiteFFFFFF
                                                          : AppColor
                                                              .reGreyA5A5A5,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Builder(
                                      builder: (context) {
                                        var list =
                                            active == 0 ? earnings : deductions;
                                        return Column(
                                          children: [
                                            for (var i = 0;
                                                i < list.length;
                                                i++)
                                              Column(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(vertical: 8),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 9.5,
                                                      horizontal: 8,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: i ==
                                                              list.length - 1
                                                          ? AppColor
                                                              .reWhiteFFFFFF
                                                          : i % 2 != 0
                                                              ? AppColor
                                                                  .reGreyBackground
                                                              : AppColor
                                                                  .reWhiteFFFFFF,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          list.keys
                                                              .elementAt(i),
                                                          style: AppTextStyle
                                                              .regular14
                                                              .copyWith(
                                                            color: AppColor
                                                                .reBlack1C1F26,
                                                          ),
                                                        ),
                                                        Text(
                                                          list.values
                                                              .elementAt(i),
                                                          style: AppTextStyle
                                                              .regular14
                                                              .copyWith(
                                                            color: AppColor
                                                                .reBlack1C1F26,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  if (i == list.length - 2)
                                                    Divider(
                                                      height: 1,
                                                      thickness: 1,
                                                      color: AppColor
                                                          .reBlack1C1F26
                                                          .withOpacity(.1),
                                                    ),
                                                ],
                                              ),
                                          ],
                                        );
                                      },
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

  Widget _buildBottomSheet(BuildContext context, SalaryViewmodel vm) {
    Map obj = {};

    for (var e in vm.salaries!) {
      var date = DateTime.parse(e.startDate.toString());
      if (!obj.containsKey(date.year)) {
        obj.addEntries({date.year: ''}.entries);
      }
    }
    List<ExpandableController> controllers = List.generate(
      obj.keys.length,
      (index) => ExpandableController(initialExpanded: false),
    );

    return StatefulBuilder(
      builder: (context, setState) => SizedBox(
        height: MediaQuery.sizeOf(context).height * .75,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Month",
                      style: AppTextStyle.bold16.copyWith(
                        color: AppColor.reBlack1C1F26,
                      ),
                    ),
                    SvgPicture.asset(
                      AppIcon.close,
                      height: 28,
                    )
                  ],
                ),
              ),
              for (var i = 0; i < controllers.length; i++)
                ExpandablePanel(
                  theme: const ExpandableThemeData(
                    tapHeaderToExpand: true,
                    tapBodyToExpand: true,
                    tapBodyToCollapse: true,
                    useInkWell: true,
                    animationDuration: Duration(
                      milliseconds: 500,
                    ),
                  ),
                  controller: controllers[i],
                  collapsed: InkWell(
                    onTap: () {
                      setState(() {
                        controllers[i].expanded = !controllers[i].expanded;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColor.reBlack1D1F1F.withOpacity(.1),
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            obj.keys.elementAt(i).toString(),
                            style: AppTextStyle.regular16.copyWith(
                              color: AppColor.reBlack1C1F26,
                            ),
                          ),
                          Transform.rotate(
                            angle: (math.pi / 180) * 180,
                            child: SvgPicture.asset(
                              AppIcon.arrowCurved,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  expanded: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            controllers[i].expanded = !controllers[i].expanded;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColor.reBlack1D1F1F.withOpacity(.1),
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                obj.keys.elementAt(i).toString(),
                                style: AppTextStyle.regular16.copyWith(
                                  color: AppColor.reBlack1C1F26,
                                ),
                              ),
                              Transform.rotate(
                                angle: (math.pi / 180) * 180,
                                child: SvgPicture.asset(
                                  AppIcon.arrowCurved,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      ...vm.salaries!
                          .where(
                            (e) =>
                                DateTime.parse(e.startDate!).year ==
                                obj.keys.elementAt(i),
                          )
                          .map(
                            (e) => Builder(
                              builder: (context) {
                                var index = vm.salaries!
                                    .where((e) =>
                                        DateTime.parse(e.startDate!).year ==
                                        obj.keys.elementAt(i))
                                    .toList()
                                    .indexOf(e);
                                return InkWell(
                                  onTap: () async {
                                    setState(() {
                                      selectedMonth = index;
                                    });
                                    await vm.getSalaryDetails(
                                      id: e.name.toString(),
                                      onError: (val) {},
                                      onSuccess: (val) {
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: AppColor.reBlack1D1F1F
                                              .withOpacity(.1),
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: index == selectedMonth
                                                ? AppColor.reBlue105F82
                                                : null,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: index == selectedMonth
                                                ? null
                                                : Border.all(
                                                    color: AppColor
                                                        .reBlack1D1F1F
                                                        .withOpacity(.1),
                                                  ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              DateTime.parse(e.startDate!)
                                                  .day
                                                  .toString(),
                                              style:
                                                  AppTextStyle.bold16.copyWith(
                                                color: index == selectedMonth
                                                    ? AppColor.reWhiteFFFFFF
                                                    : AppColor.reBlack1C1F26,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          getMonth(DateTime.parse(e.startDate!)
                                                  .month -
                                              1),
                                          style:
                                              AppTextStyle.regular16.copyWith(
                                            color: AppColor.reBlack1C1F26,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                          .toList(),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
