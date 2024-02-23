import 'package:attendance_app/app/env/app_color.dart';
import 'package:attendance_app/app/env/text_style.dart';
import 'package:attendance_app/models/attendance_model.dart';
import 'package:flutter/widgets.dart';

class AttendanceGridView extends StatefulWidget {
  const AttendanceGridView({super.key, required this.attendance});

  final List<AttendanceModel> attendance;

  @override
  State<AttendanceGridView> createState() => _AttendanceGridViewState();
}

class _AttendanceGridViewState extends State<AttendanceGridView> {
  @override
  void initState() {
    final earlyLeaves = widget.attendance.map((e) => e.earlyExit == 1).length;
    final lateEntry = widget.attendance.map((e) => e.lateEntry == 1).length;
    final present = widget.attendance.map((e) => e.status == "Present").length;
    final absents = widget.attendance.map((e) => e.status == "Absent").length;
    titles = [
      earlyLeaves.toString(),
      absents.toString(),
      lateEntry.toString(),
      present.toString(),
    ];
    super.initState();
  }

  List titles = ['-', '-', '-', '-'];
  final desc = ['Early Leaves', 'Absents', 'Late In', 'Leaves'];
  final colors = [
    AppColor.rePurple6A6AF6,
    AppColor.reBlue105F82,
    AppColor.reRedFF3B30,
    AppColor.reYellowFF9500
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Summary",
          style: AppTextStyle.regular12.copyWith(
            color: AppColor.reGrey666666,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 160,
          child: GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 75,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors[index].withOpacity(0.1),
                    // borderRadius: BorderRadius.circular(8),
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: colors[index],
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titles[index],
                        style: AppTextStyle.bold18.copyWith(
                          color: AppColor.reBlue1C1F26,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        desc[index],
                        style: AppTextStyle.regular12.copyWith(
                          color: colors[index],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
