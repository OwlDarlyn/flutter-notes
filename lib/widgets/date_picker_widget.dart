import 'package:flutter/material.dart';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/gestures/tap.dart';

class DatePiker extends StatefulWidget {
  final DateTime startDate;
  final double width;
  final double height;
  final DatePickerController? controller;
  final Color selectedTextColor;
  final Color selectionColor;
  final Color deactivatedColor;
  final TextStyle monthTextStyle;
  final TextStyle dayTextStyle;
  final TextStyle dateTextStyle;
  final DateTime? /*?*/ initialSelectedDate;
  final List<DateTime>? inactiveDates;
  final List<DateTime>? activeDates;
  final DateChangeListener? onDateChange;
  final int daysCount;
  final String locale;

  const DatePiker({
    super.key,
    required this.startDate,
    required this.width,
    required this.height,
    required this.controller,
    required this.selectedTextColor,
    required this.selectionColor,
    required this.deactivatedColor,
    required this.monthTextStyle,
    required this.dayTextStyle,
    required this.dateTextStyle,
    required this.initialSelectedDate,
    required this.inactiveDates,
    required this.activeDates,
    required this.onDateChange,
    required this.daysCount,
    required this.locale,
  });

  @override
  State<DatePiker> createState() => _DatePikerState();
}

class _DatePikerState extends State<DatePiker> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
