import 'package:attendance_app/app/app_extension/app_extensions.dart';
import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/constants.dart';
import 'package:attendance_app/app/env/text_style.dart';
import 'package:attendance_app/app/router/router.gr.dart';
import 'package:attendance_app/app/widgets/custom_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      color: AppColor.reTransparent,
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          CustomAppBar(width: MediaQuery.sizeOf(context).width),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: AppColor.reGreyBackground,
              height: MediaQuery.sizeOf(context).height - appBarHeight,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: MediaQuery.sizeOf(context).height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: appBarHeight - 50),
                  InkWell(
                    onTap: () {
                      context.router.root.push(const LoginView());
                    },
                    child: const HomeWorkType(),
                  ),
                  const SizedBox(height: 12),
                  AttendanceComponent(),
                  const SizedBox(height: 12),
                  const LeavesComponent(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LeavesComponent extends StatelessWidget {
  const LeavesComponent({
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
                    '10',
                    style: AppTextStyle.bold36,
                  ),
                ),
              )
            ],
            series: <CircularSeries>[
              DoughnutSeries<ChartData, String>(
                dataSource: chartData,
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
                    connectorLineSettings:
                        const ConnectorLineSettings(width: 0)),

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
                      Text("Used", style: AppTextStyle.regular12)
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
                      Text("Balance", style: AppTextStyle.regular12)
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
          for (var i = 0; i < 2; i++)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Casual",
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
                            Container(
                              height: 8,
                              width: i == 1 ? 60 : 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: i == 1
                                    ? AppColor.reOrangeFF9500
                                    : AppColor.reGreen00AF6C,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Center(
                        child: Text(
                          "02/05",
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
        ],
      ),
    );
  }
}

class AttendanceComponent extends StatelessWidget {
  AttendanceComponent({
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

class AttendanceGridView extends StatelessWidget {
  const AttendanceGridView({super.key});
  @override
  Widget build(BuildContext context) {
    final titles = ['02', '05', '0', '08'];
    final desc = ['Early Leaves', 'Absents', 'Late In', 'Leaves'];
    final colors = [
      AppColor.rePurple6A6AF6,
      AppColor.reBlue105F82,
      AppColor.reRedFF3B30,
      AppColor.reYellowFF9500
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Summary",
          style: AppTextStyle.regular12.copyWith(
            color: AppColor.reGrey666666,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 160,
          child: GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 75,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors[index].withOpacity(0.1),
                    // borderRadius: BorderRadius.circular(8),
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: colors[index],
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titles[index],
                        style: AppTextStyle.bold18.copyWith(
                          color: AppColor.reBlue1C1F26,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        desc[index],
                        style: AppTextStyle.regular12.copyWith(
                          color: colors[index],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

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

class HomeWorkType extends StatelessWidget {
  const HomeWorkType({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.reWhiteFFFFFF,
      ),
      padding: const EdgeInsets.all(16),
      child: _buildEndBox(),
    );
  }

  Column _buildEndBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 21.5),
        Text(
          "The End Of The Day!",
          style: AppTextStyle.regular14.copyWith(
            color: AppColor.reGrey666666,
          ),
        ),
        const SizedBox(height: 29.5),
        Image.asset(
          AppIcon.plant,
          height: 157,
        ),
        const SizedBox(height: 16.5),
        Text(
          "08:01:50",
          style: AppTextStyle.bold36.copyWith(
            color: AppColor.reBlack1C1F26,
          ),
        ),
        Text(
          "Your break time start from 02:35 PM",
          style: AppTextStyle.regular14.copyWith(
            color: AppColor.reGrey666666,
          ),
        ),
        Divider(
          height: 32,
          color: AppColor.reBlack1D1F1F.withOpacity(.1),
          thickness: 1,
        ),
        Row(
          children: [
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
        )
        // Text(
        //   "Check in and get started on your successful day.",
        //   style: AppTextStyle.regular14.copyWith(
        //     color: AppColor.reGrey666666,
        //   ),
        // )
      ],
    );
  }

  Column _buildBreakBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 21.5),
        Text(
          "It’s Your Break Time!",
          style: AppTextStyle.regular14.copyWith(
            color: AppColor.reGrey666666,
          ),
        ),
        const SizedBox(height: 29.5),
        Image.asset(
          AppIcon.cup,
          height: 113,
        ),
        const SizedBox(height: 16.5),
        Text(
          "00:15:03",
          style: AppTextStyle.bold36.copyWith(
            color: AppColor.reBlack1C1F26,
          ),
        ),
        Text(
          "Your break time start from 02:35 PM",
          style: AppTextStyle.regular14.copyWith(
            color: AppColor.reGrey666666,
          ),
        ),
        const SizedBox(height: 16),
        Container().labelButton(
          label: "End",
          verticalPadding: 16,
          horizontalPadding: 16,
          appTextStyle: AppTextStyle.medium16.copyWith(
            color: AppColor.reBlue105F82,
          ),
          radius: 12,
          borderColor: AppColor.reBlue105F82,
          color: AppColor.reWhiteFFFFFF,
        ),
        Divider(
          height: 32,
          color: AppColor.reBlack1D1F1F.withOpacity(.1),
          thickness: 1,
        ),
        Row(
          children: [
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
        )
        // Text(
        //   "Check in and get started on your successful day.",
        //   style: AppTextStyle.regular14.copyWith(
        //     color: AppColor.reGrey666666,
        //   ),
        // )
      ],
    );
  }

  Column _buildActiveWorkingBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              "Work Type",
              style:
                  AppTextStyle.regular14.copyWith(color: AppColor.reGrey606060),
            ),
            const Expanded(child: SizedBox()),
            Container(
              padding:
                  const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColor.rePrimary105F82,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppIcon.home,
                    height: 18,
                    width: 18,
                    color: AppColor.reWhiteFFFFFF,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Home",
                    style: AppTextStyle.regular14
                        .copyWith(color: AppColor.reWhiteFFFFFF),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                // color: AppColor.rePrimary105F82,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppIcon.onsite,
                    height: 18,
                    width: 18,
                    color: AppColor.reGreyA5A5A5,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Onsite",
                    style: AppTextStyle.regular14
                        .copyWith(color: AppColor.reGreyA5A5A5),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 24),
        Text(
          "03:48:50",
          style: AppTextStyle.bold36.copyWith(
            color: AppColor.reBlack1C1F26,
          ),
        ),
        Text(
          "Oct 26, 2023 - Wednesday",
          style: AppTextStyle.regular14.copyWith(
            color: AppColor.reGrey666666,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Container().labelButton(
                label: "Check out",
                verticalPadding: 16,
                horizontalPadding: 16,
                appTextStyle: AppTextStyle.medium16.copyWith(
                  color: AppColor.reBlue105F82,
                ),
                radius: 12,
                borderColor: AppColor.reBlue105F82,
                color: AppColor.reWhiteFFFFFF,
              ),
            ),
            const SizedBox(width: 8),
            Container().labelButton(
              label: "Take a break",
              verticalPadding: 16,
              horizontalPadding: 50,
              appTextStyle: AppTextStyle.medium16.copyWith(
                color: AppColor.reWhiteFFFFFF,
              ),
              radius: 12,
              borderColor: AppColor.reBlue105F82,
              color: AppColor.reBlue105F82,
            )
          ],
        ),
        Divider(
          height: 48,
          color: AppColor.reBlack1D1F1F.withOpacity(.1),
          thickness: 1,
        ),
        Row(
          children: [
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
        )
        // Text(
        //   "Check in and get started on your successful day.",
        //   style: AppTextStyle.regular14.copyWith(
        //     color: AppColor.reGrey666666,
        //   ),
        // )
      ],
    );
  }

  Column _buildCheckInBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              "Work Type",
              style:
                  AppTextStyle.regular14.copyWith(color: AppColor.reGrey606060),
            ),
            const Expanded(child: SizedBox()),
            Container(
              padding:
                  const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColor.rePrimary105F82,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppIcon.home,
                    height: 18,
                    width: 18,
                    color: AppColor.reWhiteFFFFFF,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Home",
                    style: AppTextStyle.regular14
                        .copyWith(color: AppColor.reWhiteFFFFFF),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                // color: AppColor.rePrimary105F82,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppIcon.onsite,
                    height: 18,
                    width: 18,
                    color: AppColor.reGreyA5A5A5,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Onsite",
                    style: AppTextStyle.regular14
                        .copyWith(color: AppColor.reGreyA5A5A5),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 24),
        Text(
          "08:00:50 AM",
          style: AppTextStyle.bold36.copyWith(
            color: AppColor.reBlack1C1F26,
          ),
        ),
        Text(
          "Oct 26, 2023 - Wednesday",
          style: AppTextStyle.regular14.copyWith(
            color: AppColor.reGrey666666,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: AppColor.reBlue105F82.withOpacity(.1),
          ),
          child: Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColor.reBlue105F82,
              ),
              child: Center(
                child: Text(
                  "Check in",
                  style: AppTextStyle.medium16
                      .copyWith(color: AppColor.reWhiteFFFFFF),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Check in and get started on your successful day.",
          style: AppTextStyle.regular14.copyWith(
            color: AppColor.reGrey666666,
          ),
        )
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

final List<ChartData> chartData = [
  ChartData('03', 3, AppColor.reCyan1CBECA),
  ChartData('07', 7, AppColor.reGreyEEEEEE)
];
