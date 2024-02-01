import 'package:attendance_app/app/app_extension/app_extensions.dart';
import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/constants.dart';
import 'package:attendance_app/app/env/text_style.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool secure = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.reWhiteFFFFFF,
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 108),
              child: Image.asset(
                AppIcon.logoSmall,
                height: 158,
                width: 118,
              ),
            ),
            Positioned(
              top: -80,
              left: 30,
              child: Image.asset(
                AppIcon.logoLarge,
                height: 457,
                width: 341,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(child: SizedBox()),
                  Text(
                    "Flow ERB",
                    style: AppTextStyle.bold36.copyWith(
                      color: AppColor.reBlack1C1F26,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Login to enjoy the full services provided by the Flow ERB",
                    style: AppTextStyle.regular14.copyWith(
                      color: AppColor.reGrey666666,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const TextField().formTextField(
                    label: 'Server URL',
                    actionIcon: AppIcon.archiveAdd,
                    onAction: () {},
                  ),
                  const SizedBox(height: 16),
                  const TextField().formTextField(
                    label: 'Email',
                  ),
                  const SizedBox(height: 16),
                  const TextField().formTextField(
                      label: 'Password',
                      secure: secure,
                      onSecure: () {
                        setState(() {
                          secure = !secure;
                        });
                      }),
                  const SizedBox(height: 24),
                  Container().labelButton(
                    label: 'Login',
                    appTextStyle: AppTextStyle.medium16.copyWith(
                      color: AppColor.reWhiteFFFFFF,
                    ),
                    color: AppColor.reBlue105F82,
                    verticalPadding: 16,
                    radius: 12,
                  ),
                  const SizedBox(height: 56),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}