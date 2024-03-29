import 'package:attendance_app/app/app_extension/app_extensions.dart';
import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/constants.dart';
import 'package:attendance_app/app/env/text_style.dart';
import 'package:attendance_app/app/router/router.gr.dart';
import 'package:attendance_app/app/widgets/app_global_functions.dart';
import 'package:attendance_app/view_models/user_viewmodel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool secure = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: AppColor.reWhiteFFFFFF,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).height * .25),
                        child: Image.asset(
                          AppIcon.logoSmall,
                          height: 158,
                          width: 118,
                        ),
                      ),
                      Positioned(
                        top: -(MediaQuery.sizeOf(context).height * .05),
                        left: 30,
                        child: Image.asset(
                          AppIcon.logoExtraLarge,
                          height: 457,
                          width: 341,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(child: SizedBox()),
                          Text(
                            "Flow ERP",
                            style: AppTextStyle.bold36.copyWith(
                              color: AppColor.reBlack1C1F26,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Login to enjoy the full services provided by the Flow ERP",
                            style: AppTextStyle.regular14.copyWith(
                              color: AppColor.reGrey666666,
                            ),
                          ),
                          // const SizedBox(height: 24),
                          // const TextField().formTextField(
                          //   label: 'Server URL',
                          //   actionIcon: AppIcon.archiveAdd,
                          //   controller: value.serverUrl,
                          //   onAction: () {},
                          // ),
                          const SizedBox(height: 16),
                          const TextField().formTextField(
                            label: 'Email',
                            controller: value.emailController,
                          ),
                          const SizedBox(height: 16),
                          const TextField().formTextField(
                              label: 'Password',
                              controller: value.passwordController,
                              secure: secure,
                              onSecure: () {
                                setState(() {
                                  secure = !secure;
                                });
                              }),
                          const SizedBox(height: 24),
                          value.loading
                              ? const SizedBox(
                                  height: 57,
                                  child: Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
                                )
                              : Center(
                                  child: InkWell(
                                    onTap: () async {
                                      await value.login(
                                        onSuccess: (val) {
                                          showSnackbar(
                                            context,
                                            "Login successfully",
                                            SnackbarMessageType.success,
                                          );
                                          context.router
                                              .replace(const MainView());
                                          if (value.user != null) {
                                            if (value.user!.mobileMacAddress ==
                                                null) {
                                              value.addMobile(
                                                onSuccess: (val) {},
                                                onError: (val) {
                                                  showSnackbar(
                                                      context,
                                                      'device already exist',
                                                      SnackbarMessageType
                                                          .warning);
                                                  value.logout();
                                                },
                                              );
                                            }
                                          }
                                        },
                                        onError: (val) {
                                          showSnackbar(
                                            context,
                                            val,
                                            SnackbarMessageType.warning,
                                          );
                                        },
                                      );
                                    },
                                    child: Container().labelButton(
                                      label: 'Login',
                                      appTextStyle:
                                          AppTextStyle.medium16.copyWith(
                                        color: AppColor.reWhiteFFFFFF,
                                      ),
                                      color: AppColor.reBlue105F82,
                                      verticalPadding: 16,
                                      radius: 12,
                                      onTap: () async {},
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 56),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
