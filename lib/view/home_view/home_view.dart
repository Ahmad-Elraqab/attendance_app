import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/widgets/custom_app_bar.dart';
import 'package:attendance_app/app/widgets/home_type.dart';
import 'package:attendance_app/app/widgets/leave_component.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      color: AppColor.reGreyBackground,
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              InkWell(
                  onTap: () {
                    print("object app bar");
                  },
                  child: CustomAppBar(width: MediaQuery.sizeOf(context).width)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 120),
                    InkWell(
                      onTap: () {},
                      child: const HomeWorkType(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // const SizedBox(height: 12),
          // AttendanceComponent(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 12),
                LeavesComponent(),
                SizedBox(height: 100),
              ],
            ),
          ),
          // Positioned(
          //   right: 10,
          //   bottom: 90,
          //   child: InkWell(
          //     onTap: () {
          //       // context.router.root.push(const LeaveApplicationView());
          //       context.read<AuthTokenStorage>().clear();
          //       context.router.replace(const LoginView());
          //     },
          //     child: Container(
          //       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10),
          //         color: AppColor.reBlue105F82,
          //       ),
          //       child: Center(
          //           child: Text(
          //         "Logout",
          //         style: AppTextStyle.bold10
          //             .copyWith(color: AppColor.reWhiteFFFFFF),
          //       )),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
