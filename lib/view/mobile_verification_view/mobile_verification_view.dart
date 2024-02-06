import 'package:attendance_app/app/app_extension/app_extensions.dart';
import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/constants.dart';
import 'package:attendance_app/app/env/text_style.dart';
import 'package:attendance_app/app/widgets/app_global_functions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

@RoutePage()
class MobileVerificationView extends StatefulWidget {
  const MobileVerificationView({super.key});

  @override
  State<MobileVerificationView> createState() => _MobileVerificationViewState();
}

class _MobileVerificationViewState extends State<MobileVerificationView> {
  var border = InputBorder.none;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.reGreyBackground,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // const SizedBox(height: appBarHeight),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(AppIcon.arrowLeft),
                  const SizedBox(width: 16),
                  Text(
                    "Forgot Password",
                    style: AppTextStyle.bold18
                        .copyWith(color: AppColor.reBlack1C1F26),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                AppIcon.logoSmall,
                height: 158,
              ),
            ),
            const SizedBox(height: 16),

            Text(
              "Enter your phone number",
              style: AppTextStyle.medium16.copyWith(
                color: AppColor.reBlack1C1F26,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Please enter your phone number We will send an OTP for verification to your number",
              style: AppTextStyle.regular16.copyWith(
                color: AppColor.reGrey666666,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColor.reGreyD6D6D6,
                ),
              ),
              height: 56,
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(AppIcon.flag),
                      const SizedBox(width: 8),
                      Text(
                        "+966",
                        style: AppTextStyle.regular14.copyWith(
                          color: AppColor.reBlack1C1F26,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Transform.rotate(
                        angle: math.pi / 180 * 180,
                        child: SvgPicture.asset(
                          AppIcon.arrowCurved,
                          width: 11.56,
                          color: AppColor.reGreyA5A5A5,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        color: AppColor.reBlack1D1F1F.withOpacity(.1),
                        height: 40,
                        width: 1,
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 240,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          maxLength: 9,
                          decoration: InputDecoration(
                            counter: null,
                            counterText: "",
                            border: border,
                            errorBorder: border,
                            enabledBorder: border,
                            focusedBorder: border,
                            disabledBorder: border,
                            focusedErrorBorder: border,
                            hintText: 'phone number',
                            hintStyle: AppTextStyle.regular14
                                .copyWith(color: AppColor.reGrey666666),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container().labelButton(
              label: 'Send',
              verticalPadding: 16,
              color: AppColor.reBlue105F82,
              borderColor: AppColor.reBlue105F82,
              appTextStyle: AppTextStyle.medium16.copyWith(
                color: AppColor.reWhiteFFFFFF,
              ),
              onTap: () {
                if (controller.text.isEmpty || controller.text.length < 9) {
                  showSnackbar(
                    context,
                    "correct phone is required",
                    SnackbarMessageType.info,
                  );
                } else {}
              },
              radius: 12,
            )
          ],
        ),
      ),
    );
  }
}
