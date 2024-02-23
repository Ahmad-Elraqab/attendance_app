import 'dart:async';
import 'package:attendance_app/app/app_extension/app_extensions.dart';
import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/constants.dart';
import 'package:attendance_app/app/env/text_style.dart';
import 'package:attendance_app/app/widgets/app_global_functions.dart';
import 'package:attendance_app/app/widgets/attendance_slot.dart';
import 'package:attendance_app/models/attendance_status_model.dart';
import 'package:attendance_app/view_models/attendance_viewmodel.dart';
import 'package:attendance_app/view_models/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as dt;

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class HomeWorkType extends StatefulWidget {
  const HomeWorkType({
    super.key,
  });

  @override
  State<HomeWorkType> createState() => _HomeWorkTypeState();
}

class _HomeWorkTypeState extends State<HomeWorkType> {
  late Duration period;
  @override
  void initState() {
    // context.read<FlutterSecureStorage>().delete(key: 'periods');
    getLastCheck();
    super.initState();
  }

  Future<void> getLastCheck() async {
    final vm = context.read<AttendanceViewmodel>();
    final type = await vm.getCheckStatus(
      onError: (val) {},
      onSuccess: (val) {},
    );
    if (type == AttendanceLogType.IN) {
      readPeriodsFromLocal(type);
      startTime();
    } else {
      duration = const Duration();
    }
  }

  Future<void> readPeriodsFromLocal(type) async {
    final data =
        await context.read<FlutterSecureStorage>().read(key: 'periods');
    final response = data ?? '';

    if (response == '') {
      duration = const Duration();
    } else {
      List<String> timeParts = response.split(':');

      duration = period = Duration(
        hours: int.parse(timeParts[0]),
        minutes: int.parse(timeParts[1]),
        seconds: int.parse(
          double.parse(timeParts[2]).floor().toString(),
        ),
      );
      if (type == AttendanceLogType.IN) {
        final kill =
            await context.read<FlutterSecureStorage>().read(key: 'kill');

        if (kill != null) {
          print("time diff");
          print(DateTime.now().difference(DateTime.parse(kill)));
          duration = period = Duration(
              seconds: duration!.inSeconds +
                  DateTime.now().difference(DateTime.parse(kill)).inSeconds);
        }
      }
    }
  }

  Duration? duration;
  Timer? timer;

  Duration? durationBreak = const Duration();
  Timer? timerBreak;
  bool takeBreak = false;

  void addTime({bool isBreak = false}) {
    if (isBreak) {
      const addSeconds = 1;

      setState(() {
        final seconds = durationBreak!.inSeconds + addSeconds;

        durationBreak = Duration(seconds: seconds);
      });
    } else {
      const addSeconds = 1;

      setState(() {
        final seconds = duration!.inSeconds + addSeconds;

        duration = Duration(seconds: seconds);
      });
    }
  }

  void startTime({bool isBreak = false}) {
    if (isBreak) {
      timerBreak = Timer.periodic(
          const Duration(seconds: 1), (timer) => addTime(isBreak: true));
    } else {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) => addTime());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    const FlutterSecureStorage()
        .write(key: 'periods', value: duration.toString());
    const FlutterSecureStorage()
        .write(key: 'kill', value: DateTime.now().toString());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AttendanceViewmodel>(
      builder: (context, value, child) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColor.reWhiteFFFFFF,
        ),
        padding: const EdgeInsets.all(16),
        child: value.loading
            ? const SizedBox(
                height: 400,
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              )
            : value.statusModel == null && !value.loading
                ? SizedBox(
                    height: 400,
                    child: Center(
                      child: Text(
                        "Something went wrong",
                        style: AppTextStyle.medium16
                            .copyWith(color: AppColor.reGrey666666),
                      ),
                    ),
                  )
                : takeBreak
                    ? _buildBreakBox()
                    : value.statusModel!.logType == AttendanceLogType.IN
                        ? duration == null
                            ? const SizedBox()
                            : _buildActiveWorkingBox()
                        : duration!.inHours >= 8
                            ? _buildEndBox()
                            : _buildCheckInBox(value),
      ),
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
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = twoDigits(durationBreak!.inSeconds.remainder(60));
    final minutes = twoDigits(durationBreak!.inMinutes.remainder(60));
    final hours = twoDigits(durationBreak!.inHours.remainder(60));

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
          // "00:15:03",
          "$hours:$minutes:$seconds",
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
        InkWell(
          onTap: () {
            takeBreak = false;
            timerBreak!.cancel();
          },
          child: Container().labelButton(
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

  Widget _buildActiveWorkingBox() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = twoDigits(duration!.inSeconds.remainder(60));
    final minutes = twoDigits(duration!.inMinutes.remainder(60));
    final hours = twoDigits(duration!.inHours.remainder(60));

    return Consumer<AttendanceViewmodel>(
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                "Work Type",
                style: AppTextStyle.regular14
                    .copyWith(color: AppColor.reGrey606060),
              ),
              const Expanded(child: SizedBox()),
              Container(
                padding: const EdgeInsets.only(
                    left: 8, top: 8, bottom: 8, right: 12),
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
            "$hours:$minutes:$seconds",
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
                child: ClickableWidget(
                  onClick: (
                      {required Function onError,
                      required Function onSuccess}) {
                    value.checkIn(
                      logType: AttendanceLogType.OUT,
                      deviceId: context
                          .read<UserViewModel>()
                          .user!
                          .mobileMacAddress
                          .toString(),
                      onError: (val) {
                        onError(val);
                      },
                      onSuccess: (val) async {
                        onError(val);
                        showSnackbar(context, val, SnackbarMessageType.success);
                        value.getCheckStatus(
                          willLoad: false,
                          onError: (val) {},
                          onSuccess: (val) {},
                        );

                        timer!.cancel();
                        await context
                            .read<FlutterSecureStorage>()
                            .write(
                              key: 'periods',
                              value: duration.toString(),
                            )
                            .whenComplete(() {});
                      },
                    );
                  },
                  child: Container().labelButton(
                    label: "Check out",
                    verticalPadding: 16,
                    horizontalPadding: 16,
                    onTap: null,
                    appTextStyle: AppTextStyle.medium16.copyWith(
                      color: AppColor.reBlue105F82,
                    ),
                    radius: 12,
                    borderColor: AppColor.reBlue105F82,
                    color: AppColor.reWhiteFFFFFF,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  setState(() {
                    takeBreak = !takeBreak;
                    startTime(isBreak: true);
                  });
                },
                child: Container().labelButton(
                  label: "Take a break",
                  verticalPadding: 16,
                  horizontalPadding: 50,
                  appTextStyle: AppTextStyle.medium16.copyWith(
                    color: AppColor.reWhiteFFFFFF,
                  ),
                  radius: 12,
                  borderColor: AppColor.reBlue105F82,
                  color: AppColor.reBlue105F82,
                ),
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
      ),
    );
  }

  Widget _buildCheckInBox(AttendanceViewmodel value) {
    return Consumer<AttendanceViewmodel>(
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                "Work Type",
                style: AppTextStyle.regular14
                    .copyWith(color: AppColor.reGrey606060),
              ),
              const Expanded(child: SizedBox()),
              Container(
                padding: const EdgeInsets.only(
                    left: 8, top: 8, bottom: 8, right: 12),
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
            // "08:00:50 AM",
            dt.DateFormat('hh:mm a').format(value.statusModel!.time!),
            style: AppTextStyle.bold36.copyWith(
              color: AppColor.reBlack1C1F26,
            ),
          ),
          Text(
            // "Oct 26, 2023 - Wednesday",
            "${getMonthShort(value.statusModel!.time!.month - 1)} ${value.statusModel!.time!.day}, ${value.statusModel!.time!.year} - ${getWeekDay(value.statusModel!.time!.weekday - 1)}",
            style: AppTextStyle.regular14.copyWith(
              color: AppColor.reGrey666666,
            ),
          ),
          const SizedBox(height: 24),
          ClickableWidget(
            onClick: (
                {required Function onError, required Function onSuccess}) {
              value.checkIn(
                logType: AttendanceLogType.IN,
                deviceId: context
                    .read<UserViewModel>()
                    .user!
                    .mobileMacAddress
                    .toString(),
                onError: (val) {
                  onError(val);
                },
                onSuccess: (val) {
                  onError(val);
                  showSnackbar(context, val, SnackbarMessageType.success);
                  value.getCheckStatus(
                    willLoad: false,
                    onError: (val) {},
                    onSuccess: (val) {},
                  );
                  readPeriodsFromLocal(AttendanceLogType.OUT);
                  startTime();
                },
              );
            },
            child: Container(
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
                      value.statusModel!.logType == AttendanceLogType.IN
                          ? "Check out"
                          : "Check in",
                      style: AppTextStyle.medium16
                          .copyWith(color: AppColor.reWhiteFFFFFF),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (value.statusModel!.logType == AttendanceLogType.OUT)
            Text(
              "Check in and get started on your successful day.",
              style: AppTextStyle.regular14.copyWith(
                color: AppColor.reGrey666666,
              ),
            )
          else
            const SizedBox(height: 20)
        ],
      ),
    );
  }
}

class ClickableWidget extends StatefulWidget {
  const ClickableWidget(
      {super.key, required this.onClick, required this.child});

  final Function({required Function onSuccess, required Function onError})
      onClick;
  final Widget child;

  @override
  State<ClickableWidget> createState() => _ClickableWidgetState();
}

class _ClickableWidgetState extends State<ClickableWidget> {
  final LocalAuthentication auth = LocalAuthentication();

  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  double opacity = 1;
  bool called = false;
  void onClick() {
    setState(() {
      opacity = opacity == 1 ? 0.2 : 1;
    });
  }

  @override
  void initState() {
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );

    _checkBiometrics();
    _getAvailableBiometrics();
    super.initState();
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      if (_availableBiometrics!.isNotEmpty && _canCheckBiometrics!) {
        setState(() {
          _isAuthenticating = true;
          _authorized = 'Authenticating';
        });
        authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          options: const AuthenticationOptions(
            stickyAuth: true,
          ),
        );
        setState(() {
          _isAuthenticating = false;
        });

        if (!mounted) {
          return;
        }

        setState(() =>
            _authorized = authenticated ? 'Authorized' : 'Not Authorized');
      } else {
        setState(() =>
            _authorized = authenticated ? 'Authorized' : 'Not Authorized');
      }
    } on PlatformException catch (e) {
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      onEnd: () {
        if (called) onClick();
      },
      duration: const Duration(milliseconds: 700),
      curve: Curves.linear,
      child: GestureDetector(
        onTap: () async {
          // onClick();
          await _authenticate();
          if (_authorized == 'Authorized') {
            if (!called) {
              setState(() {
                called = true;
                opacity = 0.2;
              });
              widget.onClick(
                onSuccess: (val) {
                  showSnackbar(context, val, SnackbarMessageType.warning);
                  setState(() {
                    called = false;
                    opacity = 1;
                  });
                },
                onError: (val) {
                  setState(() {
                    called = false;
                    opacity = 1;
                  });
                },
              );
            }
          } else if (_availableBiometrics!.isEmpty) {
            if (!called) {
              setState(() {
                called = true;
                opacity = 0.2;
              });
              widget.onClick(
                onSuccess: (val) {
                  showSnackbar(context, val, SnackbarMessageType.warning);
                  setState(() {
                    called = false;
                    opacity = 1;
                  });
                },
                onError: (val) {
                  setState(() {
                    called = false;
                    opacity = 1;
                  });
                },
              );
            }
          }
        },
        child: widget.child,
      ),
    );
  }
}
