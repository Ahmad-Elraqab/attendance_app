import 'package:attendance_app/app/app_view_models/app_view_model.dart';
import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/router/router.gr.dart';
import 'package:attendance_app/app/widgets/custom_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/widgets/bottom_navigation.dart';

@RoutePage()
class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColor.reWhiteFFFFFF,
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   context.router.push(
      //     NewPasswordWrapper(token: "token"),
      //   );
      // }),
      body: AutoTabsRouter(
        lazyLoad: true,
        routes: const [
          HomeView(),
          ClockView(),
          CalendarView(),
          MoneyView(),
          NotificationView(),
        ],
        homeIndex: 0,
        builder: (context, child) {
          context.read<AppViewModel>().tabsRouter = AutoTabsRouter.of(context);

          return Stack(
            children: [
              CustomAppBar(width: width),
              child,
              BottomNavigation(
                width: width,
                tabsRouter: context.watch<AppViewModel>().tabsRouter!,
              ),
            ],
          );
        },
      ),
    );
  }
}
