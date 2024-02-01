import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    super.key,
    required this.width,
    required this.tabsRouter,
  });

  final double width;
  final TabsRouter tabsRouter;
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  void onTap(index) async {
    widget.tabsRouter.setActiveIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1,
              color: AppColor.reGreyD7D7D7,
            ),
          ),
          color: AppColor.reWhiteFFFFFF,
        ),
        width: widget.width,
        height: 80,
        // margin: const EdgeInsets.only(bottom: 32),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildBottomBarItem(0, AppIcon.home, 'home'),
            buildBottomBarItem(1, AppIcon.clock, 'clock'),
            buildBottomBarItem(2, AppIcon.calendar, 'calendar'),
            buildBottomBarItem(3, AppIcon.money, 'money'),
            buildBottomBarItem(4, AppIcon.notification, 'notification'),
          ],
        ),
      ),
    );
  }

  Widget buildBottomBarItem(index, icon, title) {
    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        child: Center(
          child: SvgPicture.asset(
            icon,
            color: widget.tabsRouter.activeIndex == index
                ? AppColor.reBlack111111
                : AppColor.reGreyC3C3C3,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}
