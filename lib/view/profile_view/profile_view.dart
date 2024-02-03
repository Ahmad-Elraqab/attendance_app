import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/constants.dart';
import 'package:attendance_app/app/env/text_style.dart';
import 'package:attendance_app/app/widgets/custom_checkbox.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class ProfileDetailsView extends StatefulWidget {
  const ProfileDetailsView({super.key});

  @override
  State<ProfileDetailsView> createState() => _ProfileDetailsViewState();
}

class _ProfileDetailsViewState extends State<ProfileDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.reBlue105F82,
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: ListView(
          // alignment: Alignment.topCenter,
          children: [
            Container(
              height: 150,
              color: AppColor.reBlue105F82,
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColor.reGreyBackground,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  // height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -56,
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: AppColor.reWhiteFFFFFF,
                                borderRadius: BorderRadius.circular(45),
                              ),
                              child: Image.asset(AppIcon.profileImage),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Mohamed Abdullah",
                              style: AppTextStyle.bold20.copyWith(
                                color: AppColor.reBlack1C1F26,
                              ),
                            ),
                            Text(
                              "UI/UX Designer",
                              style: AppTextStyle.regular14.copyWith(
                                color: AppColor.reGreyA5A5A5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAccountDetails(),
                          _buildLanguage(),
                          _buildTheme(),
                          _buildMoteOptions(),
                          _buildSettings(),
                          const SizedBox(height: 42),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column _buildMoteOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          "More",
          style: AppTextStyle.bold16.copyWith(
            color: AppColor.reBlack1C1F26,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Help us",
          style: AppTextStyle.regular12.copyWith(
            color: AppColor.reGrey666666,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.reWhiteFFFFFF,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 64,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Rate",
                      style: AppTextStyle.regular16.copyWith(
                        color: AppColor.reBlack1C1F26,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    // CustomRadio(value: true, onChange: () {}),
                    SvgPicture.asset(
                      AppIcon.star,
                      height: 20,
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: AppColor.reBlack1D1F1F.withOpacity(.1),
              ),
              SizedBox(
                height: 64,
                child: Row(
                  children: [
                    Text(
                      "Share our app",
                      style: AppTextStyle.regular16.copyWith(
                        color: AppColor.reBlack1C1F26,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    SvgPicture.asset(
                      AppIcon.share,
                      height: 20,
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: AppColor.reBlack1D1F1F.withOpacity(.1),
              ),
              SizedBox(
                height: 64,
                child: Row(
                  children: [
                    Text(
                      "Report",
                      style: AppTextStyle.regular16.copyWith(
                        color: AppColor.reBlack1C1F26,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    SvgPicture.asset(
                      AppIcon.warning,
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Column _buildSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          "Account",
          style: AppTextStyle.bold16.copyWith(
            color: AppColor.reBlack1C1F26,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Your account settings",
          style: AppTextStyle.regular12.copyWith(
            color: AppColor.reGrey666666,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.reWhiteFFFFFF,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 64,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Delete account",
                      style: AppTextStyle.regular16.copyWith(
                        color: AppColor.reBlack1C1F26,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    SvgPicture.asset(
                      AppIcon.trash,
                      height: 20,
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: AppColor.reBlack1D1F1F.withOpacity(.1),
              ),
              SizedBox(
                height: 64,
                child: Row(
                  children: [
                    Text(
                      "Sign-out",
                      style: AppTextStyle.regular16.copyWith(
                        color: AppColor.reBlack1C1F26,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    SvgPicture.asset(
                      AppIcon.logout,
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Column _buildTheme() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          "Theme",
          style: AppTextStyle.bold16.copyWith(
            color: AppColor.reBlack1C1F26,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Choose the app theme that's right for you",
          style: AppTextStyle.regular12.copyWith(
            color: AppColor.reGrey666666,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.reWhiteFFFFFF,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 64,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Light",
                      style: AppTextStyle.regular16.copyWith(
                        color: AppColor.reBlack1C1F26,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    CustomRadio(value: true, onChange: () {}),
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: AppColor.reBlack1D1F1F.withOpacity(.1),
              ),
              SizedBox(
                height: 64,
                child: Row(
                  children: [
                    Text(
                      "Dark",
                      style: AppTextStyle.regular16.copyWith(
                        color: AppColor.reBlack1C1F26,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    CustomRadio(value: true, onChange: () {}),
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: AppColor.reBlack1D1F1F.withOpacity(.1),
              ),
              SizedBox(
                height: 64,
                child: Row(
                  children: [
                    Text(
                      "Automatic",
                      style: AppTextStyle.regular16.copyWith(
                        color: AppColor.reBlack1C1F26,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    CustomRadio(value: true, onChange: () {}),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Column _buildLanguage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          "Language",
          style: AppTextStyle.bold16.copyWith(
            color: AppColor.reBlack1C1F26,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Select your language",
          style: AppTextStyle.regular12.copyWith(
            color: AppColor.reGrey666666,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.reWhiteFFFFFF,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 64,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "اللغة العربية",
                      style: AppTextStyle.regular16.copyWith(
                        color: AppColor.reBlack1C1F26,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    CustomRadio(value: true, onChange: () {}),
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: AppColor.reBlack1D1F1F.withOpacity(.1),
              ),
              SizedBox(
                height: 64,
                child: Row(
                  children: [
                    Text(
                      "English",
                      style: AppTextStyle.regular16.copyWith(
                        color: AppColor.reBlack1C1F26,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    CustomRadio(value: true, onChange: () {}),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Column _buildAccountDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 154),
        Text(
          "Work details",
          style: AppTextStyle.bold16.copyWith(
            color: AppColor.reBlack1C1F26,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Your email and id",
          style: AppTextStyle.regular12.copyWith(
            color: AppColor.reGrey666666,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.reWhiteFFFFFF,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 64,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Email: ",
                      style: AppTextStyle.regular16.copyWith(
                        color: AppColor.reGrey666666,
                      ),
                    ),
                    Text(
                      "mohameduix@mail.example",
                      style: AppTextStyle.regular16.copyWith(
                        color: AppColor.reBlack1C1F26,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: AppColor.reBlack1D1F1F.withOpacity(.1),
              ),
              SizedBox(
                height: 64,
                child: Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "IDl: ",
                          style: AppTextStyle.regular16.copyWith(
                            color: AppColor.reGrey666666,
                          ),
                        ),
                        Text(
                          "265645",
                          style: AppTextStyle.regular16.copyWith(
                            color: AppColor.reBlack1C1F26,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
