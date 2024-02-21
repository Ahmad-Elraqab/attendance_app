import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/constants.dart';
import 'package:attendance_app/app/env/text_style.dart';
import 'package:attendance_app/view/home_view/home_view.dart';
import 'package:attendance_app/view_models/leave_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LeavesComponent extends StatefulWidget {
  const LeavesComponent({
    super.key,
  });

  @override
  State<LeavesComponent> createState() => _LeavesComponentState();
}

class _LeavesComponentState extends State<LeavesComponent> {
  @override
  void initState() {
    loadLeaves();
    loadLeaveTypes();
    super.initState();
  }

  Future<void> loadLeaves() async {
    context.read<LeaveViewmodel>().getLeaves(
          onError: (val) {
            // showSnackbar(context, val, SnackbarMessageType.warning);
          },
          onSuccess: (val) {},
        );
  }

  Future<void> loadLeaveTypes() async {
    context.read<LeaveViewmodel>().getLeaveTypes(
          onError: (val) {
            // showSnackbar(context, val, SnackbarMessageType.warning);
          },
          onSuccess: (val) {},
        );
  }

  List leavesTitle = ['User Leaves', 'HR Leaves', 'Approver Leaves'];

  List<Widget> buildWidgets(LeaveViewmodel value) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Leaves",
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
      Text(
        "Summary",
        style: AppTextStyle.regular12.copyWith(
          color: AppColor.reGrey666666,
        ),
        textAlign: TextAlign.start,
      ),
      const SizedBox(height: 8),
      SfCircularChart(
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
            widget: Container(
              child: Text(
                (value.hrLeaves!.length +
                        value.userLeaves!.length +
                        value.approverLeaves!.length)
                    .toString(),
                style: AppTextStyle.bold36,
              ),
            ),
          )
        ],
        series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
            dataSource: [
              ChartData(value.userLeaves!.length.toString(),
                  value.userLeaves!.length.toDouble(), AppColor.reCyan1CBECA),
              ChartData(
                  value.approverLeaves!.length.toString(),
                  value.approverLeaves!.length.toDouble(),
                  AppColor.reGreyEEEEEE),
              ChartData(value.hrLeaves!.length.toString(),
                  value.hrLeaves!.length.toDouble(), AppColor.reOrange96260A),
            ],
            dataLabelMapper: (datum, index) => datum.x,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            // Radius of doughnut's inner circle
            pointColorMapper: (datum, index) => datum.color,
            dataLabelSettings: DataLabelSettings(
                isVisible: true,
                labelPosition: ChartDataLabelPosition.outside,
                textStyle: AppTextStyle.regular16,
                showZeroValue: false,
                connectorLineSettings: const ConnectorLineSettings(width: 0)),

            innerRadius: '80%',
          )
        ],
      ),
      const SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 6,
                    backgroundColor: AppColor.reCyan1CBECA,
                  ),
                  const SizedBox(width: 3),
                  Text("User Leaves", style: AppTextStyle.regular12)
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 6,
                    backgroundColor: AppColor.reGreyEEEEEE,
                  ),
                  const SizedBox(width: 3),
                  Text("HR Leaves", style: AppTextStyle.regular12)
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 6,
                    backgroundColor: AppColor.reOrangeE23A0E,
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: Text("Approver Leaves",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.regular12),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      Divider(
        height: 32,
        thickness: 1,
        color: AppColor.reGreyEEEEEE,
      ),
      Text(
        "Types",
        style: AppTextStyle.regular12.copyWith(
          color: AppColor.reGrey666666,
        ),
      ),
      const SizedBox(height: 8),
      for (var i = 0; i < leavesTitle.length; i++)
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      leavesTitle[i],
                      style: AppTextStyle.regular14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          height: 8,
                          width: 214,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: AppColor.reGreyEEEEEE,
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            var overall = (value.hrLeaves!.length +
                                value.userLeaves!.length +
                                value.approverLeaves!.length);
                            return Container(
                              height: 8,
                              width: i == 0
                                  ? value.userLeaves!.length / overall * 214
                                  : i == 1
                                      ? value.approverLeaves!.length /
                                          overall *
                                          214
                                      : value.hrLeaves!.length / overall * 214,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: i == 0
                                    ? AppColor.reCyan1CBECA
                                    : i == 1
                                        ? AppColor.reGreyEEEEEE
                                        : AppColor.reOrange96260A,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Center(
                    child: Text(
                      i == 0
                          ? "${value.userLeaves!.length}/${value.hrLeaves!.length + value.userLeaves!.length + value.approverLeaves!.length}"
                          : i == 1
                              ? "${value.approverLeaves!.length}/${value.hrLeaves!.length + value.userLeaves!.length + value.approverLeaves!.length}"
                              : i == 2
                                  ? "${value.hrLeaves!.length}/${value.hrLeaves!.length + value.userLeaves!.length + value.approverLeaves!.length}"
                                  : "",
                      style: AppTextStyle.medium10.copyWith(
                        color: AppColor.reGreyA5A5A5,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaveViewmodel>(
      builder: (context, value, child) => Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColor.reWhiteFFFFFF,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (value.loading)
              const SizedBox(
                height: 453,
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              )
            else if (value.userLeaves == null || value.userLeaves!.isEmpty)
              SizedBox(
                height: 453,
                child: Center(
                  child: Text(
                    "Leaves are empty",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.semiBold16
                        .copyWith(color: AppColor.reBlack4D4D4D),
                  ),
                ),
              )
            else
              ...buildWidgets(value),
          ],
        ),
      ),
    );
  }
}
