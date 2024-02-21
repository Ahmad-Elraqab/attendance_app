import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/constants.dart';
import 'package:attendance_app/app/env/text_style.dart';
import 'package:attendance_app/view_models/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    super.key,
    required this.width,
  });

  final double width;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, value, child) => Align(
        alignment: Alignment.topCenter,
        child: Container(
          color: AppColor.rePrimary105F82,
          width: widget.width,
          height: 160,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      value.user == null
                          ? "Hey Mahmoud!"
                          : "${value.user?.firstName.toString()} ${value.user?.lastName.toString()}",
                      style: AppTextStyle.bold18.copyWith(
                        color: AppColor.reWhiteFFFFFF,
                      ),
                    ),
                    Text(
                      "Mark your attendance!",
                      style: AppTextStyle.regular12.copyWith(
                        color: AppColor.reWhiteFFFFFF,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColor.reWhiteFFFFFF,
                backgroundImage: AssetImage(AppIcon.profileMock),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
