import 'package:flutter/material.dart';

import '../widgets/bottom_nav_widget.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/task_list_widget.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Container(
          // margin: const EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.center,
          child: const CalendarWidget(),
        ),
      ),
    );
  }
}
