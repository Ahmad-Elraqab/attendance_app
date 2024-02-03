import 'package:attendance_app/app/env/app_color.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox(
      {super.key, required this.value, required this.onChange});

  final bool value;
  final Function onChange;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      activeColor: AppColor.reBlue105F82,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      overlayColor: MaterialStatePropertyAll(AppColor.reBlack4D4D4D),
      onChanged: (val) => onChange(val),
    );
  }
}

class CustomRadio extends StatelessWidget {
  const CustomRadio({super.key, required this.value, required this.onChange});

  final bool value;
  final Function onChange;
  @override
  Widget build(BuildContext context) {
    return Radio(
      value: value,
      activeColor: AppColor.reBlue105F82,
      groupValue: true,

      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      overlayColor: MaterialStatePropertyAll(AppColor.reGreyF9F9F9),
      onChanged: (val) => onChange(val),
    );
  }
}
