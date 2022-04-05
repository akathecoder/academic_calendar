import 'package:academic_calendar/components/home_page/scrollbar_date_widget.dart';
import 'package:flutter/material.dart';

class CustomCalendarDateScrollbar extends StatefulWidget {
  const CustomCalendarDateScrollbar({
    Key? key,
    required this.onDateChanged,
    required this.selectedDate,
  }) : super(key: key);

  final void Function(DateTime date) onDateChanged;
  final DateTime selectedDate;

  @override
  State<CustomCalendarDateScrollbar> createState() =>
      _CustomCalendarDateScrollbarState();
}

class _CustomCalendarDateScrollbarState
    extends State<CustomCalendarDateScrollbar> {
  late List<DateTime> datesListToShow;

  @override
  void initState() {
    super.initState();

    datesListToShow = getDatesInWeek(widget.selectedDate);
  }

  List<DateTime> getDatesInWeek(DateTime date) {
    List<DateTime> datesList = [];

    int weekDay = date.weekday;
    DateTime _firstDayOfWeek =
        weekDay == 7 ? date : date.subtract(Duration(days: weekDay));

    for (var i = 0; i < 7; i++) {
      datesList.add(_firstDayOfWeek.add(Duration(days: i)));
    }

    return datesList;
  }

  void handleDateClicked(DateTime date) {
    widget.onDateChanged(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              handleDateClicked(
                datesListToShow[0].subtract(const Duration(hours: 24)),
              );
              setState(() {
                datesListToShow = getDatesInWeek(widget.selectedDate);
              });
            },
            child: const Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
              size: 32.0,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var date in datesListToShow)
                    GestureDetector(
                      onTap: () => handleDateClicked(date),
                      child: ScrollbarDateWidget(
                        date: date,
                        selected: date == widget.selectedDate,
                      ),
                    ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              handleDateClicked(
                datesListToShow[6].add(const Duration(hours: 24)),
              );
              setState(() {
                datesListToShow = getDatesInWeek(widget.selectedDate);
              });
            },
            child: const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
              size: 32.0,
            ),
          ),
        ],
      ),
    );
  }
}
