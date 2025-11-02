import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:softvence_task/common_widget/switch/src/theme/theme.dart';
import 'package:softvence_task/common_widget/switch/src/widget/switch_button.dart';

class AlarmBox extends StatelessWidget {
  final DateTime dateTime;
  final bool isActive;
  final ValueChanged<bool> onToggle;

  const AlarmBox({
    super.key,
    required this.dateTime,
    required this.isActive,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0XFF201A43),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            DateFormat('h:mm a').format(dateTime),
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.0,
            children: [
              Text(
                DateFormat('d, MMMM yyyy').format(dateTime),
                style: const TextStyle(color: Colors.white70),
              ),
              AppSwitch(
                initialValue: isActive,
                focusColor: const Color(0XFF5200FF),
                switchTheme: const AppSwitchTheme(
                  activeTrackColor: Color(0XFF5200FF),
                  activeThumbColor: Color(0XFFFFFFFF),
                  inactiveThumbColor: Color(0XFF000000),
                  inactiveTrackColor: Colors.white,
                  scale: 0.7,
                ),
                onChanged: onToggle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
