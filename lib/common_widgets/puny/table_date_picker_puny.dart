import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jym_app/controller/home_screen_controller/anniversary_controller.dart';
import 'package:jym_app/controller/news_screen_controller/news_controller.dart';
import 'package:jym_app/utils/app_textstyle.dart';
import 'package:jym_app/utils/preferences.dart';
import 'package:jym_app/utils/theme_manager.dart';
import 'package:table_calendar/table_calendar.dart';

final Preferences _preferences = Preferences();

class TableDatePickerPuny extends StatefulWidget {
  NewsController newsController;
  DateTime firstDay, focusedDay;
  TableDatePickerPuny(
      {Key? key,
      required this.firstDay,
      required this.focusedDay,
      required this.newsController})
      : super(key: key);

  @override
  State<TableDatePickerPuny> createState() => _TableDatePickerPunyState();
}

class _TableDatePickerPunyState extends State<TableDatePickerPuny> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(widget.firstDay.year, widget.firstDay.month, 1),
      lastDay: DateTime.utc(widget.firstDay.year, widget.firstDay.month + 1, 1),
      focusedDay: widget.focusedDay,
      dayHitTestBehavior: HitTestBehavior.translucent,
      weekNumbersVisible: false,
      calendarFormat: CalendarFormat.week,
      calendarStyle: CalendarStyle(
        markerDecoration: BoxDecoration(
            color: ThemeManager().getThemeGreenColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20)),
        selectedDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: ThemeManager().getThemeGreenColor,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: ThemeManager().getBlackColor.withOpacity(0.085),
              offset: const Offset(2, 3),
              spreadRadius: 2.5,
              blurRadius: 3,
            ),
          ],
        ),
        isTodayHighlighted: false,
        defaultDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: ThemeManager().getWhiteColor,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: ThemeManager().getBlackColor.withOpacity(0.085),
              offset: const Offset(2, 3),
              spreadRadius: 2.5,
              blurRadius: 3,
            ),
          ],
        ),
        withinRangeDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(7),
          color: ThemeManager().getWhiteColor,
          boxShadow: [
            BoxShadow(
              color: ThemeManager().getBlackColor.withOpacity(0.085),
              offset: const Offset(2, 3),
              spreadRadius: 2.5,
              blurRadius: 3,
            ),
          ],
        ),
      ),
      selectedDayPredicate: (day) => isSameDay(day, widget.focusedDay),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          widget.focusedDay = selectedDay;
          focusedDay = widget.focusedDay;
          print(selectedDay);
        });
        var punayTithiBody = {
          "filter_from":
              "${selectedDay.year}-${selectedDay.month}-${selectedDay.day}",
          "filter_to":
              "${selectedDay.year}-${selectedDay.month}-${selectedDay.day}",
          "category_id": "10",
          "sub_category_id": "9",
          "city_id": _preferences.getCityId()
        };
        widget.newsController.getNews(punayTithiBody);
      },
      availableGestures: AvailableGestures.horizontalSwipe,
      headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          leftChevronMargin: EdgeInsets.only(left: Get.width * 0.22),
          rightChevronMargin: EdgeInsets.only(right: Get.width * 0.22),
          headerPadding: EdgeInsets.zero,
          titleTextStyle: poppinsMedium.copyWith(
            color: ThemeManager().getBlackColor,
            fontSize: Get.width * 0.05,
          ),
          leftChevronIcon: Icon(
            Icons.arrow_left_outlined,
            color: ThemeManager().getThemeGreenColor,
            size: Get.width * 0.075,
          ),
          rightChevronIcon: Icon(
            Icons.arrow_right_outlined,
            color: ThemeManager().getThemeGreenColor,
            size: Get.width * 0.075,
          ),
          titleTextFormatter: (dateTime, value) {
            return DateFormat('MMMM').format(dateTime);
          }),
      daysOfWeekVisible: false,
      sixWeekMonthsEnforced: true,
    );
  }
}
