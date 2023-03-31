import 'package:flutter/material.dart';

import '../widgets/bottom_nav_widget.dart';
import '../widgets/calendar_widget.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CalendarWidget(),
    );
  }
}
