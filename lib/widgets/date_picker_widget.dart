import 'package:flutter/material.dart';

import 'package:date_picker_timeline/gestures/tap.dart';
import 'package:date_picker_timeline/extra/style.dart';
import 'package:flutter_notes/widgets/date_widget.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../models/app_color.dart';
// import '../models/text_style.dart';

class DatePickerRow extends StatefulWidget {
  final DateTime startDate;
  final double width;
  final double height;
  final DatePickerRowController? controller;
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

  const DatePickerRow(
    this.startDate, {
    super.key,
    this.width = 50,
    this.height = 70,
    this.controller,
    this.monthTextStyle = defaultMonthTextStyle,
    this.dayTextStyle = defaultDayTextStyle,
    this.dateTextStyle = defaultDateTextStyle,
    this.selectedTextColor = Colors.white,
    this.selectionColor = AppColors.defaultSelectionColor,
    this.deactivatedColor = AppColors.defaultDeactivatedColor,
    this.initialSelectedDate,
    this.activeDates,
    this.inactiveDates,
    this.daysCount = 14,
    this.onDateChange,
    this.locale = "en_US",
  }) : assert(
            activeDates == null || inactiveDates == null,
            "Can't "
            "provide both activated and deactivated dates List at the same time.");

  @override
  State<DatePickerRow> createState() => _DatePickerRowState();
}

class _DatePickerRowState extends State<DatePickerRow> {
  DateTime? _currentDate;

  final ScrollController _controller = ScrollController();

  late final TextStyle selectedDateStyle;
  late final TextStyle selectedMonthStyle;
  late final TextStyle selectedDayStyle;

  late final TextStyle deactivatedDateStyle;
  late final TextStyle deactivatedMonthStyle;
  late final TextStyle deactivatedDayStyle;

  @override
  void initState() {
    // Init the calendar locale
    initializeDateFormatting(widget.locale, null);
    // Set initial Values
    _currentDate = widget.initialSelectedDate;

    if (widget.controller != null) {
      widget.controller!.setDatePickerRowState(this);
    }

    selectedDateStyle =
        widget.dateTextStyle.copyWith(color: widget.selectedTextColor);
    selectedMonthStyle =
        widget.monthTextStyle.copyWith(color: widget.selectedTextColor);
    selectedDayStyle =
        widget.dayTextStyle.copyWith(color: widget.selectedTextColor);

    deactivatedDateStyle =
        widget.dateTextStyle.copyWith(color: widget.deactivatedColor);
    deactivatedMonthStyle =
        widget.monthTextStyle.copyWith(color: widget.deactivatedColor);
    deactivatedDayStyle =
        widget.dayTextStyle.copyWith(color: widget.deactivatedColor);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: ListView.builder(
        itemCount: widget.daysCount,
        scrollDirection: Axis.horizontal,
        controller: _controller,
        itemBuilder: (context, index) {
          DateTime date;
          DateTime _date = widget.startDate.add(Duration(days: index));
          date = DateTime(_date.year, _date.month, _date.day);

          bool isDeactivated = false;

          if (widget.inactiveDates != null) {
            for (DateTime inactiveDates in widget.inactiveDates!) {
              if (_compareDate(date, inactiveDates)) {
                isDeactivated = true;
                break;
              }
            }
          }

          if (widget.activeDates != null) {
            isDeactivated = true;
            for (DateTime activeDates in widget.activeDates!) {
              if (_compareDate(date, activeDates)) {
                isDeactivated = false;
                break;
              }
            }
          }

          bool isSelected =
              _currentDate != null ? _compareDate(date, _currentDate!) : false;

          return DateWidget(
            date: date,
            monthTextStyle: isDeactivated
                ? deactivatedMonthStyle
                : isSelected
                    ? selectedMonthStyle
                    : widget.monthTextStyle,
            dayTextStyle: isDeactivated
                ? deactivatedDateStyle
                : isSelected
                    ? selectedDateStyle
                    : widget.dateTextStyle,
            dateTextStyle: isDeactivated
                ? deactivatedDayStyle
                : isSelected
                    ? selectedDayStyle
                    : widget.dayTextStyle,
            width: widget.width,
            locale: widget.locale,
            selectionColor:
                isSelected ? widget.selectionColor : Colors.transparent,
            onDateSelected: (selectedDate) {
              if (isDeactivated) return;

              if (widget.onDateChange != null) {
                widget.onDateChange!(selectedDate);
              }
              setState(() {
                _currentDate = selectedDate;
              });
            },
          );
        },
      ),
    );
  }

  bool _compareDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }
}

class DatePickerRowController {
  _DatePickerRowState? _datePickerRowState;

  void setDatePickerRowState(_DatePickerRowState state) {
    _datePickerRowState = state;
  }

  void jumpToSelection() {
    assert(_datePickerRowState != null,
        'DatePickerController is not attached to any DatePicker View.');
    _datePickerRowState!._controller
        .jumpTo(_calculateDateOffset(_datePickerRowState!._currentDate!));
  }

  void animateToSelection(
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerRowState != null,
        'DatePickerController is not attached to any DatePicker View.');

    // animate to the current date
    _datePickerRowState!._controller.animateTo(
        _calculateDateOffset(_datePickerRowState!._currentDate!),
        duration: duration,
        curve: curve);
  }

  void animateToDate(DateTime date,
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerRowState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerRowState!._controller.animateTo(_calculateDateOffset(date),
        duration: duration, curve: curve);
  }

  void setDateAndAnimate(DateTime date,
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerRowState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerRowState!._controller.animateTo(_calculateDateOffset(date),
        duration: duration, curve: curve);

    if (date.compareTo(_datePickerRowState!.widget.startDate) >= 0 &&
        date.compareTo(_datePickerRowState!.widget.startDate
                .add(Duration(days: _datePickerRowState!.widget.daysCount))) <=
            0) {
      // date is in the range
      _datePickerRowState!._currentDate = date;
    }
  }

  double _calculateDateOffset(DateTime date) {
    final startDate = DateTime(
        _datePickerRowState!.widget.startDate.year,
        _datePickerRowState!.widget.startDate.month,
        _datePickerRowState!.widget.startDate.day);

    int offset = date.difference(startDate).inDays;
    return (offset * _datePickerRowState!.widget.width) + (offset * 6);
  }
}
